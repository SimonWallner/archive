class SearchController < ApplicationController
	def result
		query = '^"' + params[:query] + '"'
		
		@game_results = GameVersioner.instance.current_versions_from_collection Game.find_with_index(query)
		@dev_results = DeveloperVersioner.instance.current_versions_from_collection Developer.find_with_index(query)
		@com_results = CompanyVersioner.instance.current_versions_from_collection Company.find_with_index(query)
	end
end
