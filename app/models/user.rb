class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def show_name
    if defined? self.name
      self.name.present? ? self.name : self.email.split('@').first
    else
      self.email.split('@').first
    end
  end
end
