class GenresController < ApplicationController
  # GET /genres
  # GET /genres.json
  def index
    @genres = Genre.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @genre = Genre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /genres/new
  # GET /genres/new.json
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /genres/1/edit
  def edit
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(params[:genre])

    respond_to do |format|
      if @genre.save
<<<<<<< HEAD
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }

=======
        format.html { redirect_to @genre }
        format.json { render json: @genre, status: :created, location: @genre }
>>>>>>> 40fe9b763bf4f7e24ec1cd42f33780068e06fff0
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /genres/1
  # PUT /genres/1.json
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
<<<<<<< HEAD
        format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }

=======
        format.html { redirect_to @genre }
        format.json { head :no_content }
>>>>>>> 40fe9b763bf4f7e24ec1cd42f33780068e06fff0
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      format.html { redirect_to genres_url }
    end
  end
end
