class TagsController < ApplicationController
  before_filter :authenticate_admin!

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end
  
  # GET /tags/1/join
  def join
    @tag = Tag.find(params[:id])
  end
  
  # POST /tags
  def create
    @tag = Tag.new(params[:tag])
    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /tags/1
  def update
    @tag = Tag.find(params[:id])
		
	if params[:new_tags]
		params[:new_tags].strip!
		@join_tag =  Tag.find_by_name(params[:new_tags])
		@game = @tag.games
		if @join_tag
			@game.all.each do |g|
				if(not g.tags.include?(@join_tag))
					g.tags << @join_tag
				end
			end
			@tag.destroy
		else
			@tag.name = params[:new_tags]
			@tag.save
		end		
	end
	
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /tags/1
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
    end
  end
end
