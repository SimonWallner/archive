class TagsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :get]
  
  def get
    if params[:term]
      if params[:type]
        if params[:type] == 'developer'
          @devs = Developer.where("name LIKE ?", "#{params[:term]}%")
          @devs.collect! do |dev|
            {:value => 'dev:' + dev.name + ',', :label => dev.name + ' - Developer'}
          end
          @comps = Company.where("name LIKE ?", "#{params[:term]}%")
          @comps.collect! do |comp|
            {:value => 'comp:' + comp.name + ',', :label => comp.name + ' - Company'}
          end
          @tags = @devs.concat(@comps)
        else

        end
      else

      @devs = Developer.where("name LIKE ?", "#{params[:term]}%")
      @devs.collect! do |dev|
        {:value => '[' + dev.name + '](' + developer_url(dev) + ')', :label => dev.name + ' - Developer'}
      end

      @games = Game.where("title LIKE ?", "#{params[:term]}%")
      @games.collect! do |game|
        {:value => '[' + game.title + '](' + game_url(game) + ')', :label => game.title + ' - Game'}
      end

      @comps = Company.where("name LIKE ?", "#{params[:term]}%")
      @comps.collect! do |comp|
        {:value => '[' + comp.name + '](' + company_url(comp) + ')', :label => comp.name + ' - Company'}
      end

      @tags = @devs
      @tags = @tags.concat(@games)
      @tags = @tags.concat(@comps)

      end

      respond_to do |format|
        format.json { render :json => @tags}
      end
    end
  end
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

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
end
