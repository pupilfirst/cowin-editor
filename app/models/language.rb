class Language < ApplicationRecord
  has_many :categories, dependent: :destroy
end
