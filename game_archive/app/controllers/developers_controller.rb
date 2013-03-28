class DevelopersController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show, :report, :update, :new_report, :create_report]
	before_filter only: [:edit, :show] { |c| c.block_content_visitor 1 } 
	before_filter only: [:edit] { |c| c.block_content_user 1 }
	before_filter :authenticate_admin!, only: [:block]
	#before_filter :blocked_user!, except: [:index, :show, :report, :update]

	@@DEVELOPER_VERSIONER = DeveloperVersioner.instance
	
	# GET /developers
	# GET /developers.json
	def index
		@developers = @@DEVELOPER_VERSIONER.all_current_versions

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @developers }
		end
	end

	# GET /developers/1
	def show
		some_version = Developer.find(params[:id])
		@developer = @@DEVELOPER_VERSIONER.current_version some_version

		# redirect to other page if game is not newest version
		if @developer != some_version
			redirect_to @developer, :status => :moved_permanently
			return
		end

		if @developer.popularity == nil 
			@developer.popularity = 0
			@developer.save
		end
		@developer.increment!(:popularity)

		respond_to do |format|
			format.html # show.html.erb
			format.json { render :json => @developer.to_json(:include => [:mixed_fields, :fields ]) }
		end
	end

	# GET /developers/new
	# GET /developers/new.json
	def new
		@developer = Developer.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @developer }
		end
	end

	# GET /developers/1/edit
	def edit
		@developer = @@DEVELOPER_VERSIONER.current_version Developer.find(params[:id])
	end
	
	# POST /developers
	def create
		@developer = Developer.new(params[:developer])
		@@DEVELOPER_VERSIONER.add_versioning_to_new_object @developer, current_user

		@developer.popularity = 0
		Field.create_add_new_fields(@developer, params[:new_fields])
		respond_to do |format|
			if @developer.save
				format.html { redirect_to @developer }
			else
				format.html { render action: "new" }
			end
		end
	end

	# PUT /developers/1
	def update
		@developer = @@DEVELOPER_VERSIONER.current_version Developer.find(params[:id])

		old = @developer
		@developer = @@DEVELOPER_VERSIONER.new_version old, params
		Field.create_add_new_fields(@developer, params[:new_fields])

		if @developer.update_attributes(params[:developer])
			format.html { redirect_to @developer}
		else
			# delete newest version
			old.add_errors @developer.errors
			@developer.destroy
			@developer = old
			format.html { render action: "edit" }
		end
	end
	
	# GET developers/1/report
	def new_report
		@report = Reportblockcontent.new
		@kind = 'Developer'
		render 'reportblockcontents/new_report'
	end
	
	# POST developers/1/report
	def create_report		
		# XXX Refactor using polymorphic model
		report = Reportblockcontent.new(params[:report])
		report.content_id = params[:id]
		report.content_type = Reportblockcontent::DEVELOPER 
		report.status = Reportblockcontent::REPORTED
		report.save

		flash[:alert] = "Thank you for submitting the report!"
		redirect_to :action => "show", :id => params[:id] 
	end
end
