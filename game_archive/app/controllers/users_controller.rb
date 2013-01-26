class UsersController < ApplicationController

	before_filter :authenticate_admin!
	
  def manage
  end
  
  def update
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
					if @user.blocked?
						format.html { redirect_to "/users/manage", notice: 'user is blocked and cannot be promoted, unblock first' }
					elsif not @user.admin?
						@user.toggle!(:admin)
						@user.update_attribute(:note, "")
						@user.save
						format.html { redirect_to root_path, notice: 'user was promoted to admin' }
					else
						format.html { redirect_to "/users/manage", notice: 'user is already admin' }
					end
				elsif s == 'demote'
					if @user.admin?
						@user.toggle!(:admin)
						@user.update_attribute(:note, params[:reason])
						@user.save
						format.html { redirect_to root_path, notice: 'user was demoted from admin successfully, reason: ' + @user.note }
					else
						format.html { redirect_to "/users/manage", notice: 'user is not an admin' }
					end
				elsif s == 'block'
					if @user.admin?
						format.html { redirect_to "/users/manage", notice: 'user is admin and cannot be blocked, demote first' }
					elsif @user.blocked?
						format.html { redirect_to "/users/manage", notice: 'user is already blocked' }
					else
						@user.toggle!(:blocked)
						@user.update_attribute(:note, params[:reason])
						@user.save
						format.html { redirect_to root_path, notice: 'user was blocked successfully, reason: ' + @user.note }
					end
				elsif s == 'unblock'
					if not @user.blocked?
						format.html { redirect_to "/users/manage", notice: 'user is already unblocked' }
					else
						@user.toggle!(:blocked)
						@user.update_attribute(:note, "")
						@user.save
						format.html { redirect_to root_path, notice: 'user was unblocked successfully' }
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
