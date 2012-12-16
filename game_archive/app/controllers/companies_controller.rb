class CompaniesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :report]
  before_filter only: [:edit, :show] { |c| c.block_content_visitor 2 } 
  before_filter only: [:edit] { |c| c.block_content_user 2 }
  before_filter :authenticate_admin!, only: [:block]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(2,params[:id])
	if @company.popularity == nil 
		@company.popularity = 0
		@company.save
	end
	@company.increment!(:popularity)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
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
    @company = Company.find(params[:id])
  end

  # GET /games/1/report
  def report
	@reportblockcontent =Reportblockcontent.new
    @company = Company.find(params[:id])	
  end
  
  # GET /games/1/block
  def block
	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(2,params[:id])
    @company = Company.find(params[:id])
  end
  
  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])
	@company.popularity = 0

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])
	if (params[:reportblockcontent])
		Reportblockcontent.create_from_string(2,params[:id], params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
	end
	
	
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
