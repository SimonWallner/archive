class GamesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :report, :update]
  before_filter only: [:edit, :show] { |c| c.block_content_visitor 0 }
  before_filter only: [:edit] { |c| c.block_content_user 0 } 
  before_filter :authenticate_admin!, only: [:block]

  #before_filter :blocked_user!, except: [:index, :show, :report, :update]
   @@GAME_VERSIONER = GameVersioner.instance

  
  # GET /games
  # GET /games.json
  def index
    @games = @@GAME_VERSIONER.all_current_versions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    some_version = Game.find(params[:id])
    @game = @@GAME_VERSIONER.current_version some_version

    # redirect to other page if game is not newest version
    if @game != some_version and !params[:version]
      redirect_to @game
      return
    else
      if params[:version]
        @game = Game.where(:version_id => @game.version_id, :version_number => params[:version]).first!
        if params[:makecurrent]
          @@GAME_VERSIONER.revert_to_this @game
        end
      end
    end

	  @reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(0,@game.id)
	  if @game.popularity == nil
		  @game.popularity = 0
		  @game.save
	  end
	  @game.increment!(:popularity)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @game.to_json() }
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
    @game = @@GAME_VERSIONER.current_version Game.find(params[:id])
  end
  
   # GET /games/1/report
  def report
    @game = @@GAME_VERSIONER.current_version Game.find(params[:id])
    @reportblockcontent =Reportblockcontent.new
  end
  
  # GET /games/1/block
  def block
    @game = @@GAME_VERSIONER.current_version Game.find(params[:id])
    return if @game == nil
    @reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(0,@game.id)
  end
  
  # GET /games/1/delete
  def delete
    @game = @@GAME_VERSIONER.current_version Game.find(params[:id])
    return if @game == nil
    @reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(0,@game.id)
  end
  
  # POST /games
  def create
    @game = Game.new(params[:game])
    @@GAME_VERSIONER.add_versioning_to_new_object @game, current_user

	  @game.popularity = 0
    create_add_new_token(params[:new_genres], params[:new_platforms], params[:new_medias], params[:new_modes], params[:new_tags])
    create_add_new_release_dates(params[:new_release_dates])
    Field.create_add_new_fields(@game, params[:new_fields])

	respond_to do |format|
      if @game.save
        create_add_new_mixed_fields(params[:new_developers], MixedFieldType.find_by_name("Developer"))
        create_add_new_mixed_fields(params[:new_publishers], MixedFieldType.find_by_name("Publisher"))
        create_add_new_mixed_fields(params[:new_distributors], MixedFieldType.find_by_name("Distributor"))
        create_add_new_mixed_fields(params[:new_credits], MixedFieldType.find_by_name("Credits"))
        create_add_new_mixed_fields(params[:new_series], MixedFieldType.find_by_name("Series"))

        format.html { redirect_to @game}
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /games/1
  def update
    @game = @@GAME_VERSIONER.current_version Game.find(params[:id])

    if current_user
      if !current_user.blocked
        if (params[:reportblockcontent])
          Reportblockcontent.create_from_string(0,@game.id, params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
        else
          old = @game
          @game = @@GAME_VERSIONER.new_version old
          create_add_new_token(params[:new_genres], params[:new_platforms], params[:new_medias], params[:new_modes], params[:new_tags])
          create_add_new_release_dates(params[:new_release_dates])
          Field.create_add_new_fields(@game, params[:new_fields])
        end
      else
        if params[:reportblockcontent]&& params[:reportblockcontent][:status]=='0'
          Reportblockcontent.create_from_string(0,@game.id, params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
        end
      end
    else
        if params[:reportblockcontent]&& params[:reportblockcontent][:status]=='0'
          Reportblockcontent.create_from_string(0,@game.id, params[:reportblockcontent][:reason], params[:reportblockcontent][:status], params[:reportblockcontent][:email], nil)#, params[:user][:id])
        end
    end

    respond_to do |format|
      if current_user
        if !current_user.blocked
          if params[:reportblockcontent] && params[:reportblockcontent][:status]=='0'
            format.html { redirect_to @game,notice: 'Game was reported successfully'}
          else
            # update video
            update_video_params params, old
            if @game.update_attributes(params[:game])
              create_add_new_mixed_fields(params[:new_developers], MixedFieldType.find_by_name("Developer"))
              create_add_new_mixed_fields(params[:new_publishers], MixedFieldType.find_by_name("Publisher"))
              create_add_new_mixed_fields(params[:new_distributors], MixedFieldType.find_by_name("Distributor"))
              create_add_new_mixed_fields(params[:new_credits], MixedFieldType.find_by_name("Credits"))
              create_add_new_mixed_fields(params[:new_series], MixedFieldType.find_by_name("Series"))
              format.html { redirect_to @game}
            else
              # delete newest version
              old.add_errors @game.errors
              @game.destroy
              @game = old
              format.html { render action: "edit" }
            end
          end
        else
          if params[:reportblockcontent] && params[:reportblockcontent][:status]=='0'
            format.html { redirect_to @game,notice: 'Game was reported successfully'}
          else
            format.html { redirect_to @game,notice: 'you have been blocked, reason: ' + current_user.note}
          end
        end
      else
        if params[:reportblockcontent] && params[:reportblockcontent][:status]=='0'
          format.html { redirect_to @game,notice: 'Game was reported successfully'}
        else
          redirect_to root_path, notice: 'you need to be registered and signed up in order to access this page'
        end
	    end
    end
  end

  private
  def update_video_params(params, old)
    return if params == nil || old == nil
    vp = params[:game][:videos_attributes]
    return if vp == nil
    logger.debug 'update video params'
    logger.debug vp
    vhash = @@GAME_VERSIONER.new_video_hash old
    vp.each do |k, v|
      id = v[:id].to_i
      v[:id] = vhash[id].to_s
    end
    logger.debug 'finished updating video params'
    logger.debug vp
  end
  # takes the new_genres_string and the game_params string
  # creates new genres if necessary
  # and augments the game_params with the new genres
  def create_add_new_token(genres_string, platforms_string, media_string, modes_string, tags_string)
    @game.genres.clear
    @game.platforms.clear
    @game.media.clear
    @game.modes.clear
    @game.tags.clear

    Genre.create_from_string(genres_string)
    Platform.create_from_string(platforms_string)
    Medium.create_from_string(media_string)
    Mode.create_from_string(modes_string)
    Tag.create_from_string(tags_string)    
 
    begin
      if genres_string == nil  
        return
    end
      new_genres = genres_string.split ','
      new_genres.try(:each) do |ng|
        ng.strip!
        new_genre = Genre.find_by_name(ng)
        if(not @game.genres.include?(new_genre))
          @game.genres << new_genre
        end
      end
    rescue
    end

    begin
        if platforms_string == nil  
      return
    end
       new_platforms = platforms_string.split ','
      new_platforms.try(:each) do |np|
        np.strip!
        new_platform = Platform.find_by_name(np)
        if(not @game.platforms.include?(new_platform))
          @game.platforms << new_platform
        end
      end
    rescue
    end

    begin
   if media_string == nil  
      return
    end
        new_media = media_string.split ','
      new_media.try(:each) do |nm|
        nm.strip!
        new_medium = Medium.find_by_name(nm)
        if(not @game.media.include?(new_medium))
          @game.media << new_medium
        end
      end
    rescue
    end


    begin
     if modes_string == nil  
      return
    end
        new_modes = modes_string.split ','
      new_modes.try(:each) do |nm|
        nm.strip!
        new_mode = Mode.find_by_name(nm)
        if(not @game.modes.include?(new_mode))
          @game.modes << new_mode
        end
      end
    rescue
    end


    begin
   if tags_string == nil  
      return
    end
        new_tags = tags_string.split ','
      new_tags.try(:each) do |nt|
        nt.strip!
        new_tag = Tag.find_by_name(nt)
        if(not @game.tags.include?(new_tag))
          @game.tags << new_tag
        end
      end
    rescue
    end

  end

  def create_add_new_release_dates(rd_string)
    @game.release_dates.clear
    if rd_string == nil
      logger.debug "rdstring nil"
      return
    end
    logger.debug "create rds from string"
    rds = ReleaseDate.create_from_string(rd_string)
    rds.each do |rd|
      logger.debug rd
      @game.release_dates.push rd
    end
  end

  # takes 2 arguments:
  # mixed_field_string represents the string which is sent from the client, which represents a mixed field
  # mixed_field_type represents the mixed_field_type object
  def create_add_new_mixed_fields(mixed_field_string, mixed_field_type)
    logger.debug "create mixed fields"
    #easy way -> needs to be improved later (versioning)
    remove_all_mixed_fields @game, mixed_field_type
    #remove text mixed fields
    #remove_text_mixed_fields @game
    #reload game due to possibly removed mixed fields
    @game = Game.find @game.id
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
  # "@dev:[developer_id]:[additional_info]"
  # "@comp:[company_id]:[additional_info]"
  # "@game:[game_id]:[additional_info]"
  # "[other_name]:[additional_info]"
  # where
  # [developer_id], [company_id] and [game_id] reflect a correct developer, company or game id
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
    if elem0 == "@dev" || elem0 == "@comp" || elem0 == "@game"
      create_referenced_mixed_field_entity mfe_array, mixed_field_type, elem0
    else
      create_text_mixed_field_entity mfe_array, mixed_field_type
    end
  end

  # takes 3 arguments
  # mixed_field_array is an array with information about the mixed field (as specified before create_mixed_field_entity)
  # mixed_field_type is the type object as stored in mixed_field_type
  # reference_type is either "@dev" or "@comp" which stands for developer and company
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

    if reference_type == "@dev"
      logger.debug "dev mixed field"
      begin
        developer = Developer.find id
        logger.debug "developer found: " + developer.name
      rescue ResourceNotFound
        # no developer for given id found
        logger.debug "no developer for id #{id} found"
        return
      end

      begin
        mf = get_mixed_field @game, developer, mixed_field_type
        if mf == nil
          mf = MixedField.new
        end
        mf.mixed_field_type_id= mixed_field_type.id
        mf.additional_info= additional_info
        mf.game_id= @game.id
        mf.developer_id= developer.id
        mf.save
        logger.debug "saved mixed field: " + mf.id.to_s
      rescue Exception => e
        logger.warn "something went wrong when trying to create mixed field: " + e.message
      end
    elsif reference_type == "@game"
      logger.debug "game series mixed field"
      begin
        game = Game.find id
      rescue ResourceNotFound
        # no game found
        logger.debug "no game for #{id} found"
        return
      end

      begin
        mf = get_mixed_field @game, game, mixed_field_type
        if mf == nil
          mf = MixedField.new
        end
        mf.mixed_field_type_id= mixed_field_type.id
        mf.additional_info= additional_info
        mf.game_id= @game.id
        mf.series_game_id= game.id
        mf.save
        logger.debug "saved mixed field: " + mf.id.to_s
      rescue Exception => e
        logger.warn "something went wrong when trying to create mixed field: " + e.message
      end
    elsif reference_type == "@comp"
      logger.debug "comp mixed field"
      begin
        company = Company.find id
      rescue ResourceNotFound
        # no developer for given id found
        logger.debug "no company for id #{id} found"
        return
      end

      begin
        mf = get_mixed_field @game, company, mixed_field_type
        if mf == nil
          mf = MixedField.new
        end
        mf.mixed_field_type_id= mixed_field_type.id
        mf.additional_info= additional_info
        mf.game_id= @game.id
        mf.company_id= company.id
        mf.save
        logger.debug "saved mixed field: " + mf.id.to_s
      rescue Exception => e
        logger.warn "something went wrong when trying to create mixed field: " + e.message
      end
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

    begin
      mf = MixedField.new
      mf.mixed_field_type_id= mixed_field_type.id
      mf.additional_info= additional_info
      mf.game_id= @game.id
      mf.not_found= text
      mf.save
      logger.debug "saved mixed field: " + mf.id.to_s
    rescue Exception => e
      logger.warn "something went wrong when trying to create mixed field: " + e.message
    end
  end

  # checks if for the given game a mixed field is already present
  # returns it if present otherwise returns nil
  def get_mixed_field(game, relation, type)
    if game == nil || relation == nil || type == nil
      return nil
    end

    mfs = game.mixed_fields
    begin
      if relation.is_a? Company
        logger.debug "relation is a company"
        #returns the record which matches the provided attributes
        return MixedField.where(:game_id => game.id, :company_id => relation.id, :mixed_field_type_id => type.id).first
      elsif relation.is_a? Developer
        logger.debug "relation is a developer"
        #returns the record which matches the provided attributes
        return MixedField.where(:game_id => game.id, :developer_id => relation.id, :mixed_field_type_id => type.id).first
      elsif relation.is_a? Game
        logger.debug "relation is a game"
        return MixedField.where(:game_id => game.id, :series_game_id => relation.id, :mixed_field_type_id => type.id).first
      else
        # nothing
        logger.debug "unknown relation"
        return nil
      end
    rescue RecordNotFound
      # do nothing here
      logger.debug "no record found"
    end
    return nil
  end

  def remove_text_mixed_fields(game)
    if game == nil
      return
    end
    deleted = MixedField.where(["game_id = ? AND (NOT (not_found = NULL))", game.id]).delete_all
    logger.debug deleted.to_s + " text mixed fields deleted"
  end

  def remove_all_mixed_fields(game, mixed_field_type)
    if game == nil || mixed_field_type == nil
      return
    end
    mfs = MixedField.where(:game_id => game.id, :mixed_field_type_id => mixed_field_type.id).delete_all
  end
end
