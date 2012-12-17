class ReportblockcontentsController < ApplicationController
  before_filter :authenticate_admin!
    
  def index
    @reportblockcontents = Reportblockcontent.all
  end
  
  
  def destroy
    @reportblockcontents = Reportblockcontent.find(params[:id])
    @reportblockcontents.destroy

    respond_to do |format|
      format.html { redirect_to reportblockcontents_url }
      format.json { head :no_content }
    end
  end
end
