class PlatformsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /platforms
  # GET /platforms.json
  def index
    @platforms = Platform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @platforms }
    end
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
    @platform = Platform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/new
  # GET /platforms/new.json
  def new
    @platform = Platform.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/1/edit
  def edit
    @platform = Platform.find(params[:id])
  end

  # POST /platforms
  def create
    @platform = Platform.new(params[:platform])
    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: 'Platform was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /platforms/1
  def update
    @platform = Platform.find(params[:id])
    respond_to do |format|
      if @platform.update_attributes(params[:platform])
        format.html { redirect_to @platform, notice: 'Platform was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /platforms/1
  def destroy
    @platform = Platform.find(params[:id])
    @platform.destroy
    respond_to do |format|
      format.html { redirect_to platforms_url }
    end
  end
end
