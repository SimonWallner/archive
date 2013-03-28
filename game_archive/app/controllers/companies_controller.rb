require "json"

class CompaniesController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show, :report, :update, :new_report, :create_report]
	before_filter only: [:edit, :show] { |c| c.block_content_visitor 2 } 
	before_filter only: [:edit] { |c| c.block_content_user 2 }
	before_filter :authenticate_admin!, only: [:block]
	#before_filter :blocked_user!, except: [:index, :show, :report, :update]

	@@COMPANY_VERSIONER = CompanyVersioner.instance
	
	# GET /companies
	# GET /companies.json
	def index
		@companies = @@COMPANY_VERSIONER.all_current_versions

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @companies }
		end
	end

	# GET /companies/1/version1
	def show_version
		needle = Company.find(params[:id])
		@company = Company.where(:version_id => needle.version_id, :version_number => params[:version]).first!
		@versions = Company.where :version_id => @company.version_id
		@show_restore = true;
		render "show"
	end
	
	# POST /companies/1/version/2
	def restore_version
		needle = Company.find(params[:id])
		@company = Company.where(:version_id => needle.version_id, :version_number => params[:version]).first!
		
		@new_version = @@COMPANY_VERSIONER.revert_to_this @company
		redirect_to @new_version
	end
		
	# GET /companies/1
	# GET /companies/1.json
	def show
		some_version = Company.find(params[:id])
		@company = @@COMPANY_VERSIONER.current_version some_version
		@show_restore = false;

		# redirect to other page if game is not newest version
		if @company != some_version
			redirect_to @company, :status => :moved_permanently
			return
		end

		if @company.popularity == nil
			@company.popularity = 0
			@company.save
		end
		@company.increment!(:popularity)

		respond_to do |format|
			format.html # show.html.erb
			format.json { render :json => @company.to_json() }
		end
	end

	# GET /companies/new
	# GET /companies/new.json
	def new
		@company = Company.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @company }
		end
	end

	# GET /companies/1/edit
	def edit
		@company = @@COMPANY_VERSIONER.current_version Company.find(params[:id])
	end
	
	# GET /companies/1/block
	# def block
	# 	@company = @@COMPANY_VERSIONER.current_version Company.find(params[:id])
	# 	return if @company == nil
	# 	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(2, @company.id)
	# end
	# 
	# # GET /companies/1/delete
	# def delete
	# 	@company = @@COMPANY_VERSIONER.current_version Company.find(params[:id])
	# 	return if @company == nil
	# 	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(2, @company.id)
	# end
	
	# POST /companies
	def create
		@company = Company.new(params[:company])
		@@COMPANY_VERSIONER.add_versioning_to_new_object @company, current_user

		@company.popularity = 0

		Location.create_add_new_locations(@company, params["new_locations"])
		add_founded(params)
		add_defunct(params)
		Field.create_add_new_fields(@company, params[:new_fields])
		respond_to do |format|
			if @company.save
				format.html { redirect_to @company }
			else
				format.html { render action: "new" }
			end
		end
	end

	# PUT /companies/1
	def update
		old = @@COMPANY_VERSIONER.current_version Company.find(params[:id])

		@company = @@COMPANY_VERSIONER.new_version old, params
		Location.create_add_new_locations(@company, params["new_locations"])
		add_founded(params)
		add_defunct(params)
		Field.create_add_new_fields(@company, params[:new_fields])

		if @company.update_attributes(params[:company])
			redirect_to @company
		else
			# delete newest version created
			old.add_errors @company.errors
			@company.destroy
			@company = old
			render action: "edit"
		end
	end
	
	# GET games/1/report
	def new_report
		@report = Reportblockcontent.new
		@kind = 'Company'
		render 'reportblockcontents/new_report'
	end
	
	# POST games/1/report
	def create_report		
		# XXX Refactor using polymorphic model
		report = Reportblockcontent.new(params[:report])
		report.content_id = params[:id]
		report.content_type = Reportblockcontent::COMPANY 
		report.status = Reportblockcontent::REPORTED
		report.save

		flash[:alert] = "Thank you for submitting the report!"
		redirect_to :action => "show", :id => params[:id] 
	end
	

	def add_founded(params)
		param_founded = params[:founded]
		if param_founded == nil
			logger.debug "no founded param received"
		end


		cf = @company.founded
		if(cf != nil)
			logger.debug "founded is not nil"
			nr_deleted = CompanyFounded.where(:company_id => @company.id).delete_all
			logger.debug nr_deleted.to_s + "deleted founded records"
			@company = Company.find @company.id
		end

		if param_founded == nil || param_founded.length < 2
			logger.debug "param_founded not provided or to short"
			return
		end

		logger.debug param_founded
		json_object = JSON.parse param_founded
		logger.debug json_object

		if ( not json_object.is_a?( Hash ) )
			logger.debug "json object is no Hash"
			return
		end

		#params[:company][:founded] = json_object

		cf = CompanyFounded.new
		cf.year = json_object["year"].to_i
		cf.month = json_object["month"].to_i unless json_object["month"] == nil
		cf.day = json_object["day"].to_i unless json_object["day"] == nil
		@company.build_founded :year => cf.year, :month => cf.month, :day => cf.day
	end

	def add_defunct(params)
		param_defunct = params[:defunct]
		if param_defunct == nil
			logger.debug "no defunct param received"
		end


		cd = @company.defunct
		if(cd != nil && @company.id != nil)
			logger.debug "defunct is not nil"
			nr_deleted = CompanyDefunct.where(:company_id => @company.id).delete_all
			logger.debug nr_deleted.to_s + "deleted defunct records"
			@company = Company.find @company.id
		end

		if param_defunct == nil || param_defunct.length < 2
			logger.debug "param_defunct not provided or to short"
			return
		end

		logger.debug param_defunct
		json_object = JSON.parse param_defunct
		logger.debug json_object

		if ( not json_object.is_a?( Hash ) )
			logger.debug "json object is no Hash"
			return
		end

		#params[:company][:defunct] = json_object
		cd = CompanyDefunct.new
		cd.year = json_object["year"].to_i
		cd.month = json_object["month"].to_i unless json_object["month"] == nil
		cd.day = json_object["day"].to_i unless json_object["day"] == nil
		cd.additional_info = json_object["additional_info"]
		@company.build_defunct :year => cd.year, :month => cd.month, :day => cd.day, :additional_info => cd.additional_info
	end
end
