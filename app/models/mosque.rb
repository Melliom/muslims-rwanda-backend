# frozen_string_literal: true

class Mosque < ApplicationRecord
  has_one :imam, class_name: "Sheikh", foreign_key: "mosque_id", dependent: :nullify,  inverse_of: :mosque
  validates :name, presence: :true, length: { minimum: 3, maximum: 100 }
  validates :address, presence: :true, length: { minimum: 3, maximum: 100 }
  validates :size, presence: :true
  validates :momo_number, uniqueness: {  message: "this number already exists for another mosque" }
  validates :cashpower, uniqueness: true
  enum size: {
    small: 0,
    medium: 1,
    large: 2,
  }
end
