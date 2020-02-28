# frozen_string_literal: true

class Sheikh < ApplicationRecord
  has_one_attached :avatar
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
  validates :tel, length: { is: 10 }
end
