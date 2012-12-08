class GamesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
	if @game.popularity == nil 
		@game.popularity = 0
	end
	@game.increment!(:popularity)
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @genres = Genre.all
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create


    @game = Game.new(params[:game])
	@game.popularity = 0
    create_add_new_genres(params[:new_genres])


	respond_to do |format|
      if @game.save
        format.html { redirect_to @game}
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    create_add_new_genres(params[:new_genres])
	
    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
  # takes the new_genres_string and the game_params string
  # creates new genres if necessary
  # and augments the game_params with the new genres
  def create_add_new_genres(genres_string)
    @game.genres.clear
    if genres_string == nil
      return
    end
    Genre.create_from_string(genres_string)
    new_genres = genres_string.split ','
    if new_genres.size == 0
      return
    end
	begin
    new_genres.try(:each) do |ng|
      ng.strip!
      new_genre = Genre.find_by_name(ng)
      if(not @game.genres.include?(new_genre))
        @game.genres << new_genre
      end
    end
	rescue # nil exception due to "empty" arguments such as ", , ,"
		#redirect_to @game, notice: 'Genres nicht korrekt angegeben!'
		return
	end
  end
end
