class TagsController < ApplicationController
  def get
    if params[:term]

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

      respond_to do |format|
        format.json { render :json => @tags}
      end
    end
  end
end
