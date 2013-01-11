class DevelopersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :report, :update]
  before_filter only: [:edit, :show] { |c| c.block_content_visitor 1 } 
  before_filter only: [:edit] { |c| c.block_content_user 1 }
  before_filter :authenticate_admin!, only: [:block]
  before_filter :blocked_user!, except: [:index, :show, :report, :update]
  
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
  def create
    @developer = Developer.new(params[:developer])
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
    @developer = Developer.find(params[:id])
    if params[:reportblockcontent]
      Reportblockcontent.create_from_string(1,params[:id], params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
    end
    Field.create_add_new_fields(@developer, params[:new_fields])
    respond_to do |format|
      if @developer.update_attributes(params[:developer])
        if params[:reportblockcontent] && params[:reportblockcontent][:status]=='0'
          format.html { redirect_to @developer,notice: 'Developer was reported successfully'}
        else
          format.html { redirect_to @developer}
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /developers/1
  def destroy
    @developer = Developer.find(params[:id])
    @developer.destroy

    respond_to do |format|
      format.html { redirect_to developers_url }
    end
  end
end
