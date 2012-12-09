require "json"

class CompaniesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

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

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])
    Location.create_add_new_locations(@company, params["new_locations"])
    add_founded(params)
    add_defunct(params)

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
    Location.create_add_new_locations(@company, params["new_locations"])
    add_founded(params)
    add_defunct(params)

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
