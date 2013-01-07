class SearchController < ApplicationController
	def result
		query = params[:query]
		
		@game_results = Game.find_with_index(query)
		@dev_results = Developer.find_with_index(query)
		@com_results = Company.find_with_index(query)
	end
end
