# frozen_string_literal: true

class Announcement < ApplicationRecord
  validates :title, presence: :true, length: { minimum: 3, maximum: 300 }
  validates :description, length: { minimum: 3 }
  enum status: {
    active: 0,
    archived: 1,
  }
end
