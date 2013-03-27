class ReportblockcontentsController < ApplicationController
	before_filter :authenticate_admin!
		
	def index
		@reports = Reportblockcontent.where("status = ?", Reportblockcontent::REPORTED)
	end
	 
	
 def destroy
	 @reportblockcontents = Reportblockcontent.find(params[:id])
	 @reportblockcontents.destroy

	redirect_to reportblockcontents_url, :notice => "Report deleted."
	end
end
