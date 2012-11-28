class User < ActiveRecord::Base
  VALID_PASSWORD_PATTERN = /\A\z|\A.*(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*\z/

  validates :password, format: {
      :with => VALID_PASSWORD_PATTERN,
      :message => "must contain at least 1 lowercase letter, 1 uppercase letter and 1 digit"
  }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
