class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  def authenticate_admin!
	(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
  
  def authenticate_inviter!
	authenticate_admin!
  end
  
  def authenticate_user!(*tmp)
	if current_user.nil?
		redirect_to root_path, notice: 'you need to be registered and signed up in order to access this page'
	elsif current_user.blocked?
		redirect_to root_path, notice: 'you have been blocked, reason: ' + current_user.note
	end
  end
  
  def block_content_visitor (type)
	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(type,params[:id])
	if (@reportblockcontent)
		if current_user.nil?
			if (@reportblockcontent.status== 1)
				if @reportblockcontent.reason
					flash[:alert] = "The content has been blocked due to: " + @reportblockcontent.reason
				else
					flash[:alert] = "The content has been blocked."
				end
				redirect_to root_path
			else if (@reportblockcontent.status== 4)
								if @reportblockcontent.reason
					flash[:alert] = "The content has been deleted due to: " + @reportblockcontent.reason
				else
					flash[:alert] = "The content has been deleted."
				end
				redirect_to root_path
			end
			end
		end
	end
  end
  
  
  def block_content_user (type)
	
	@reportblockcontent =Reportblockcontent.find_by_content_type_and_content_id(type,params[:id])

	if (@reportblockcontent)
		if @reportblockcontent.status==2 and !current_user.admin
				if @reportblockcontent.reason
					flash[:alert] = "The content has been locked due to" + @reportblockcontent.reason
				else
					flash[:alert] = "The content has been locked." 
				end
				if type ==0
					@game = Game.find(params[:id])
					redirect_to @game
				end
				if type ==1
					@developer = Developer.find(params[:id])
					redirect_to @developer
				end
				if type ==2
					@company = Company.find(params[:id])
					redirect_to @company
				end
				
		end
	end
end
	
   
  
end
