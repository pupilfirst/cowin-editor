class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :rememberable,
         :omniauthable,
         omniauth_providers: %i[google_oauth2 facebook]

  has_many :docs, dependent: :destroy
  has_many :markdown_attachments, dependent: :restrict_with_error

  def password_required?
    false
  end
end
