# frozen_string_literal: true

class Sheikh < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
  against: [:names, :telephone],
  using: {
    trigram: {
      threshold: 0.2
    }
  },
  ranked_by: ":trigram"

  has_one_attached :avatar
  belongs_to :mosque, optional: true
  enum role: {
    regular: 0,
    imam: 1,
  }
  enum status: {
    active: 0,
    inactive: 1,
  }

  validates :avatar, content_type: [:png, :jpeg, :jpg], size: { less_than: 3.megabytes, message: "size must be under 3MB" }
  validates :names, presence: :true, length: { minimum: 3, maximum: 100 }
  validates :telephone, length: { is: 10 }, uniqueness: true
end
