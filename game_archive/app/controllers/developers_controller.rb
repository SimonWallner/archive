class DevelopersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :report]
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
  # GET /developers/1.json
  def show
    some_version = Developer.find(params[:id])
    @developer = @@DEVELOPER_VERSIONER.current_version some_version

    # redirect to other page if game is not newest version
    if @developer != some_version
      redirect_to @developer
      return
    end

	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(1,@developer.id)
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

   # GET /developers/1/report
  def report
    @developer = @@DEVELOPER_VERSIONER.current_version Developer.find(params[:id])
    @reportblockcontent =Reportblockcontent.new
  end
  
  # GET /developers/1/block
  def block
    @developer = @@DEVELOPER_VERSIONER.current_version Developer.find(params[:id])
    return if @developer == nil
    @reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(1, @developer.id)
  end
  
  # GET /developers/1/delete
  def delete
    @developer = @@DEVELOPER_VERSIONER.current_version Developer.find(params[:id])
    return if @developer == nil
    @reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(1,@developer.id)
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
    old = Developer.find(params[:id])
    @developer = @@DEVELOPER_VERSIONER.new_version old

    if params[:reportblockcontent]
      Reportblockcontent.create_from_string(1,@developer.id, params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
    elsif
      Field.create_add_new_fields(@developer, params[:new_fields])
    end

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
