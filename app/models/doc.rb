class Doc < ApplicationRecord
  include PgSearch::Model
  belongs_to :category
  belongs_to :user

  pg_search_scope :search_full_text,
                  against: {
                    title: 'A',
                    excerpt: 'B',
                    content: 'C',
                  }
end
