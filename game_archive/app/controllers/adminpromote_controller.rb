class AdminpromoteController < ApplicationController
  def promote
	authenticate_user!
  end
  
  def update
	authenticate_user!
	respond_to do |format| 
		# search for user
		if params[:user_email] != ''
			p = params[:user_email]
			@user = User.find_by_email(p)
		elsif params[:firstname] != '' and params[:lastname] != '' # funktioniert noch nicht
			p = params[:firstname]
			q = params[:lastname]
			@user = User.find(:all, :conditions => ["firstname = ? and lastname = ?", p, q]).first
			#@user = User.find_by_firstname_and_lastname(p, q)
		else
			format.html { redirect_to "/adminpromote/promote", notice: 'you must enter either a mail adress or a full user name!' }
		end
		
		# update user if found
		if @user == nil
			format.html { redirect_to "/adminpromote/promote", notice: 'user not found in database!' }
		else
			s = params[:todo]
			if s
				if s == 'promote' 
					if not @user.admin?
						@user.toggle!(:admin)
						format.html { redirect_to root_path, notice: 'user was promoted to admin' }
					else
						format.html { redirect_to "/adminpromote/promote", notice: 'user is already admin' }
					end
				elsif s == 'demote'
					if @user.admin?
						@user.toggle!(:admin)
						format.html { redirect_to root_path, notice: 'user was demoted from admin' }
					else
						format.html { redirect_to "/adminpromote/promote", notice: 'user is not an admin' }
					end
				else
					format.html { redirect_to root_path, notice: 'now this is weird ' }
				end
			else
				format.html { redirect_to "/adminpromote/promote", notice: 'you must set whether to promote or demote the user!' }
			end		
		end
    end
  end
end
