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
    create_add_new_genres(params[:new_genres])

	respond_to do |format|
      if @game.save
        @game = Game.find params[:id]
        create_add_new_mixed_fields(params[:new_developers], MixedFieldType.find_by_name("Developer"))
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
        create_add_new_mixed_fields(params[:new_developers], MixedFieldType.find_by_name("Developer"))
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
        if not @game.genres.include?(new_genre)
          @game.genres << new_genre
        end
      end
    rescue # nil exception due to "empty" arguments such as ", , ,"
      #redirect_to @game, notice: 'Genres nicht korrekt angegeben!'
      return
    end
  end

  # takes 2 arguments:
  # mixed_field_string represents the string which is sent from the client, which represents a mixed field
  # mixed_field_type represents the mixed_field_type object
  def create_add_new_mixed_fields(mixed_field_string, mixed_field_type)
    logger.debug "create mixed fields"
    @game.mixed_fields.clear
    if mixed_field_string == nil || mixed_field_type == nil
      logger.debug "mf returning"
      return
    end


    new_mixed_fields = mixed_field_string.split ','
    logger.debug(new_mixed_fields.size.to_s + " mixed fields to add for " + @game.title)
    if new_mixed_fields.size == 0
      return
    end

    begin
      new_mixed_fields.try(:each) do |nf|
        create_mixed_field_entity nf, mixed_field_type
      end
    rescue
      return
    end
  end

  # takes a string and creates a correct mixed field entry
  # strings can look as followed:
  # "dev:[developer_id]:[additional_info]"
  # "comp:[company_id]:[additional_info]"
  # "[other_name]:[additional_info]"
  # where
  # [developer_id] and [company_id] reflect a correct developer or company id
  # [other_name] can be any string representing a company or developer not created in the system (yet)
  # [additional_info] can be any string, which represents additional text. OPTIONAL
  def create_mixed_field_entity(mixed_field_entity, mixed_field_type)
    if mixed_field_type == nil || mixed_field_entity == nil
      return
    end
    mixed_field_entity.strip!
    mfe_array = mixed_field_entity.split ':'
    if mfe_array.size < 1
      return
    end

    # check if type is specified
    elem0 = mfe_array[0].strip
    if elem0 == "dev" || elem0 == "comp"
      create_referenced_mixed_field_entity mfe_array, mixed_field_type, elem0
    else
      create_text_mixed_field_entity mfe_array, mixed_field_type
    end
  end

  # takes 3 arguments
  # mixed_field_array is an array with information about the mixed field (as specified before create_mixed_field_entity)
  # mixed_field_type is the type object as stored in mixed_field_type
  # reference_type is either "dev" or "comp" which stands for developer and company
  # creates the mixed_field entry with the given data if successful
  # returns nothing if not successful
  def create_referenced_mixed_field_entity(mixed_field_array, mixed_field_type, reference_type)
    if mixed_field_array == nil || mixed_field_type == nil || reference_type == nil ||  mixed_field_array.size < 2
      return
    end

    id = mixed_field_array[1].strip
    if mixed_field_array.size >= 3
      additional_info = mixed_field_array[2].strip
    end

    if reference_type == "dev"
      logger.debug "dev mixed field"
      begin
        developer = Developer.find id
        logger.debug "developer found: " + developer.name
      rescue ResourceNotFound
        # no developer for given id found
        logger.debug "no developer for id #{id} found"
        return
      end
      logger.debug "create mixed field"
      logger.debug "dev id " + developer.id.to_s
      logger.debug "type id " + mixed_field_type.id.to_s
      logger.debug "additional info: " + additional_info
      logger.debug "game id: " + @game.id.to_s
      e = MixedField.exists? :game_id => @game.id
      logger.debug e.to_s

      mf = MixedField.new
      logger.debug "mf: " + mf
      #(:mixed_field_type_id => mixed_field_type.id, :additional_info => additional_info, :game_id => @game.id, :developer_id => developer.id, :company_id => nil, :not_found => nil)
      mf.mixed_field_type_id= mixed_field_type.id
      mf.additional_info= additional_info
      mf.game_id= @game.id
      mf.developer_id= developer.id
      logger.debug "mf id: " + mf.id
      mf.save
      logger.debug "saved dev"
    elsif reference_type == "comp"
      logger.debug "comp mixed field"
      begin
        company = Company.find id
      rescue ResourceNotFound
        # no developer for given id found
        logger.debug "no company for id #{id} found"
        return
      end
      mf = MixedField.new(:company_id => developer.id, :mixed_field_type_id => mixed_field_type.id, :additional_info => additional_info, :game_id => @game.id, :developer_id => nil, :not_found => nil)
      mf.save
    end

    if mf == nil
      logger.debug "could not save Mixed Field"
    else
      logger.debug "saved Mixed Field " + mf.id
    end
  end

  def create_text_mixed_field_entity(mixed_field_array, mixed_field_type)
    if mixed_field_array == nil || mixed_field_type == nil || mixed_field_array.size < 1
      return
    end
    logger.debug "text mixed field"

    text = mixed_field_array[0].strip
    if mixed_field_array.size >= 2
      additional_info = mixed_field_array[1].strip
    end
    mf = MixedField.new :not_found => text, :game_id => @game.id, :additional_info => additional_info, :mixed_field_type_id => mixed_field_type.id, :company_id => nil, :developer_id => nil
    mf.save
  end
end
