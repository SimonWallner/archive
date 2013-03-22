class ReportblockcontentsController < ApplicationController
	before_filter :authenticate_admin!
		
	def index
		@reportblockcontents = Reportblockcontent.all
	end
	 
	
 def destroy
	 @reportblockcontents = Reportblockcontent.find(params[:id])
	 @reportblockcontents.destroy

	redirect_to reportblockcontents_url, :notice => "Report deleted."
	end
end
