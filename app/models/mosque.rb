# frozen_string_literal: true

class Mosque < ApplicationRecord
  include PgSearch::Model
  include Filterable

  scope :all_active, -> { where(archived: false) }
  scope :find_active, -> (id) { all_active.find(id) }
  pg_search_scope :filter_by_search,
  against: :name,
  using: {
    trigram: {
      threshold: 0.2
    }
  },
  ranked_by: ":trigram"
  scope :filter_by_imam, -> (imam_id) { self.joins(:imam).where(sheikhs: { id: imam_id }) }
  scope :filter_by_size, -> (size) { where(size: size) }





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
