class User < ActiveRecord::Base
  
  has_secure_password

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, 
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
                      :on => :create
  validates_length_of :password, :in => 7..15                    
end
