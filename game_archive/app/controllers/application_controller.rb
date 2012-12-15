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
end
