class TagsController < ApplicationController
  def get
    if params[:term]
      @devs = Developer.where("name LIKE ?", "#{params[:term]}%")

      @devs.collect! do |dev|
        {:value => dev.name, :label => dev.name + ' - Developer'}
      end

      @games = Game.where("title LIKE ?", "#{params[:term]}%")

      @games.collect! do |game|
        {:value => game.title, :label => game.title + ' - Game'}
      end
      @tags = @devs.merge(@games)
      respond_to do |format|
        format.json { render :json => {:all => @tags}}
      end
    end
  end
end
