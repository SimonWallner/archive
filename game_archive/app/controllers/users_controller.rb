class UsersController < ApplicationController
  def manage
	authenticate_admin!
  end
  
  def update
	authenticate_admin!
	respond_to do |format| 
		# search for user
		if params[:user_email] != ''
			p = params[:user_email]
			@user = User.find_by_email(p)
		elsif params[:firstname] != '' and params[:lastname] != ''
			p = params[:firstname]
			q = params[:lastname]
			@user = User.find(:all, :conditions => ["firstname = ? and lastname = ?", p, q]).first
		else
			format.html { redirect_to "/users/manage", notice: 'you must enter either a mail adress or a full user name!' }
		end
		
		# update user if found
		if @user == nil
			format.html { redirect_to "/users/manage", notice: 'user not found in database!' }
		else
			s = params[:todo]
			if s
				if s == 'promote' 
					if not @user.admin?
						@user.toggle!(:admin)
						format.html { redirect_to root_path, notice: 'user was promoted to admin' }
					else
						format.html { redirect_to "/users/manage", notice: 'user is already admin' }
					end
				elsif s == 'demote'
					if @user.admin?
						@user.toggle!(:admin)
						format.html { redirect_to root_path, notice: 'user was demoted from admin' }
					else
						format.html { redirect_to "/users/manage", notice: 'user is not an admin' }
					end
				else
					format.html { redirect_to root_path, notice: 'now this is weird ' }
				end
			else
				format.html { redirect_to "/users/manage", notice: 'you must set whether to promote or demote the user!' }
			end		
		end
    end
  end
end
