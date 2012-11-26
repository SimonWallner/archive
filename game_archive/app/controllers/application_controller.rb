class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  def authenticate_inviter!
	(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
end
