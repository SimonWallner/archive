class ModesController < ApplicationController
  before_filter :authenticate_admin!
  
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
  
  # GET /modes/1/join
  def join
    @mode = Mode.find(params[:id])
  end
  
  # POST /modes
  def create
    @mode = Mode.new(params[:mode])
    respond_to do |format|
      if @mode.save
        format.html { redirect_to @mode, notice: 'Mode was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /modes/1
  def update
    @mode = Mode.find(params[:id])
		
	if params[:new_modes]
		params[:new_modes].strip!
		@join_mode =  Mode.find_by_name(params[:new_modes])
		@game = @mode.games
		if @join_mode
			@game.all.each do |g|
				if(not g.modes.include?(@join_mode))
					g.modes << @join_mode
				end
			end
			@mode.destroy
		else
			@mode.name = params[:new_modes]
			@mode.save
		end		
	end
	
    respond_to do |format|
      if @mode.update_attributes(params[:mode])
        format.html { redirect_to @mode, notice: 'Mode was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /modes/1
  def destroy
    @mode = Mode.find(params[:id])
    @mode.destroy
    respond_to do |format|
      format.html { redirect_to modes_url }
    end
  end
end
