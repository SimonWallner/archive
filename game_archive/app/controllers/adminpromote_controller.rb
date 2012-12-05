class AdminpromoteController < ApplicationController
  def promote
	authenticate_user!
  end
  
  def update
	if params[:email] 
		p = params[:email]
		@user = User.find(:first, :conditions => ["email LIKE %?%",p])
	elsif params[:firstname]
		p = params[:firstname]
		@user = User.find(:first, :conditions => ["firstname LIKE %?%",p])
	elsif params[:lastname]
		p = params[:lastname]
		@user = User.find(:first, :conditions => ["lastname LIKE %?%",p])
	else
		# error flash message
	end
	
	if params[:action_promote]
		# set user to admin
	elsif params[:action_demote]
		# unset user from admin
	else
		# error flash message
	end
	
	respond_to do |format|  
	  
      if @user.save
		# wenn user mit namen oder email existiert, admin-flag setzen
		# ansonsten error flash message
        format.html { redirect_to home_path }
      else
        format.html { render action: "promote" }
      end
    end
  end
end
