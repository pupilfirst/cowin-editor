class Category < ApplicationRecord
  belongs_to :language
  has_many :docs, dependent: :destroy
end
