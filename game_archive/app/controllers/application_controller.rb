class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  def authenticate_inviter!
    if current_user.admin?
		return current_user
	end
  end
end
