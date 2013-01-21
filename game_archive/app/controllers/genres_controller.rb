class GenresController < ApplicationController
  before_filter :authenticate_admin!

  # GET /genres
  # GET /genres.json
  def index
    @genres = Genre.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @genres }
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @genre = Genre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/new
  # GET /genres/new.json
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/1/edit
  def edit
    @genre = Genre.find(params[:id])
  end
  
  # GET /genres/1/join
  def join
    @genre = Genre.find(params[:id])
  end
  
  # POST /genres
  def create
    @genre = Genre.new(params[:genre])
    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /genres/1
  def update
    @genre = Genre.find(params[:id])
	
	if params[:new_genres]
		params[:new_genres].strip!
		@join_genre =  Genre.find_by_name(params[:new_genres])
		@game = @genre.games
		if @join_genre
			@game.all.each do |g|
				if(not g.genres.include?(@join_genre))
					g.genres << @join_genre
				end
			end
			@genre.destroy
		else
			@genre.name = params[:new_genres]
			@genre.save
		end		
	end
	
    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        format.html { redirect_to @genre }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /genres/1
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    respond_to do |format|
      format.html { redirect_to genres_url }
    end
  end
end
