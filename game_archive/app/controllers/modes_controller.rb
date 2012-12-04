class ModesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  # GET /modes
  # GET /modes.json
  def index
    @modes = Mode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @modes }
    end
  end

  # GET /modes/1
  # GET /modes/1.json
  def show
    @mode = Mode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mode }
    end
  end

  # GET /modes/new
  # GET /modes/new.json
  def new
    @mode = Mode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mode }
    end
  end

  # GET /modes/1/edit
  def edit
    @mode = Mode.find(params[:id])
  end

  # POST /modes
  # POST /modes.json
  def create
    @mode = Mode.new(params[:mode])

    respond_to do |format|
      if @mode.save
        format.html { redirect_to @mode, notice: 'Mode was successfully created.' }
        format.json { render json: @mode, status: :created, location: @mode }
      else
        format.html { render action: "new" }
        format.json { render json: @mode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /modes/1
  # PUT /modes/1.json
  def update
    @mode = Mode.find(params[:id])

    respond_to do |format|
      if @mode.update_attributes(params[:mode])
        format.html { redirect_to @mode, notice: 'Mode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modes/1
  # DELETE /modes/1.json
  def destroy
    @mode = Mode.find(params[:id])
    @mode.destroy

    respond_to do |format|
      format.html { redirect_to modes_url }
      format.json { head :no_content }
    end
  end
end
