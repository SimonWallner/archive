class MediaController < ApplicationController
  before_filter :authenticate_admin!
  # GET /media
  # GET /media.json
  def index
    @media = Medium.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  # GET /media/1
  # GET /media/1.json
  def show
    @medium = Medium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/new
  # GET /media/new.json
  def new
    @medium = Medium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/1/edit
  def edit
    @medium = Medium.find(params[:id])
  end
  
  # GET /media/1/join
  def join
    @medium = Medium.find(params[:id])
  end
  
  # POST /media
  def create
    @medium = Medium.new(params[:medium])
    respond_to do |format|
      if @medium.save
        format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /media/1
  def update
    @medium = Medium.find(params[:id])
		
	if params[:new_medias]
		params[:new_medias].strip!
		@join_medium =  Medium.find_by_name(params[:new_medias])
		@game = @medium.games
		if @join_medium
			@game.all.each do |g|
				if(not g.media.include?(@join_medium))
					g.media << @join_medium
				end
			end
			@medium.destroy
		else
			@medium.name = params[:new_medias]
			@medium.save
		end		
	end
	
    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /media/1
  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
    respond_to do |format|
      format.html { redirect_to media_url }
    end
  end
end
