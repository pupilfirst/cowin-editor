class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  def password_required?
  false
  end
end
