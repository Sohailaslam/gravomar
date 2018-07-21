class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :lockable,:recoverable, :rememberable, :registerable, :trackable, :confirmable, :validatable,:omniauthable, omniauth_providers: %i[facebook linkedin google_oauth2 twitter]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  
  # validates_uniqueness_of :username       
  def make_admin
    self.update!(admin: true)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.linkedin_link = auth.info.urls.public_profile if auth.provider=="linkedin"
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end
  
  
  
end
