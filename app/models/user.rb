class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2] #remove other lines for exclusive GoogleLogin

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID   
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| # remove or_create if want exclusive precharged accounts
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
    end
  end

  def show_name
    if defined? self.name
      self.name.present? ? self.name : self.email.split('@').first
    else
      self.email.split('@').first
    end
  end
end
