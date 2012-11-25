class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  def authenticate_inviter!
    current_user.admin?
  end
end
