# frozen_string_literal: true

class Sheikh < ApplicationRecord
  enum role: {
    regular: 0,
    imam: 1,
  }

  validates :names, presence: :true, length: { minimum: 3, maximum: 100 }
  validates :tel, length: { is: 10 }
  validates :avatar, url: true
end
