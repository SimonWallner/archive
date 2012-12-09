class AjaxController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :get]

  def get
    if params[:term]
      if params[:type]
        if params[:type] == 'developer'
          @devs = Developer.where("name LIKE ?", "#{params[:term]}%")
          @devs.collect! do |dev|
            {:value => '@dev:' + dev.id.to_s + ':additional-info,', :label => dev.name + ' - Developer'}
          end
          @comps = Company.where("name LIKE ?", "#{params[:term]}%")
          @comps.collect! do |comp|
            {:value => '@comp:' + comp.id.to_s + ':additional-info,', :label => comp.name + ' - Company'}
          end
          @tags = @devs.concat(@comps)
        elsif params[:type] == 'game'
          @games = Game.where("title LIKE ?", "#{params[:term]}%")
          @games.collect! do |game|
            {:value => '@game:' + game.id.to_s + ':additional-info,', :label => game.title + ' - Game'}
          end
          @tags = @games
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
    elsif params[:type] == 'all'
      if params[:field] == 'genres'
        @tags = Genre.all.collect {|x| x.name}
      elsif params[:field] == 'platform'
        @tags = Platform.all.collect {|x| x.name}
      elsif params[:field] == 'mode'
        @tags = Mode.all.collect {|x| x.name}
      elsif params[:field] == 'media'
        @tags = Medium.all.collect {|x| x.name}
      elsif params[:field] == 'tags'
        @tags = Tag.all.collect {|x| x.name}
      end
    end

    respond_to do |format|
      format.json { render :json => @tags}
    end
  end
end