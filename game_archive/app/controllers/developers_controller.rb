class DevelopersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :report]
  before_filter only: [:edit, :show] { |c| c.block_content_visitor 1 } 
  before_filter only: [:edit] { |c| c.block_content_user 1 }
  before_filter :authenticate_admin!, only: [:block]
  
  # GET /developers
  # GET /developers.json
  def index
    @developers = Developer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @developers }
    end
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
    @developer = Developer.find(params[:id])
	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(1,params[:id])
	if @developer.popularity == nil 
		@developer.popularity = 0
		@developer.save
	end
	@developer.increment!(:popularity)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @developer }
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
    @developer = Developer.find(params[:id])
  end

   # GET /games/1/report
  def report
	@reportblockcontent =Reportblockcontent.new
    @developer = Developer.find(params[:id])	
  end
  
  # GET /games/1/block
  def block
	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(1,params[:id])
    @developer = Developer.find(params[:id])
  end
  
  # POST /developers
  # POST /developers.json
  def create
    @developer = Developer.new(params[:developer])
	@developer.popularity = 0

    respond_to do |format|
      if @developer.save
        format.html { redirect_to @developer }
        format.json { render json: @developer, status: :created, location: @developer }
      else
        format.html { render action: "new" }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /developers/1
  # PUT /developers/1.json
  def update
    @developer = Developer.find(params[:id])
	if (params[:reportblockcontent])
		Reportblockcontent.create_from_string(1,params[:id], params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
	end
	
    respond_to do |format|
      if @developer.update_attributes(params[:developer])
        format.html { redirect_to @developer}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    @developer = Developer.find(params[:id])
    @developer.destroy

    respond_to do |format|
      format.html { redirect_to developers_url }
      format.json { head :no_content }
    end
  end
end
