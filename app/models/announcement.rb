# frozen_string_literal: true

class Announcement < ApplicationRecord
  scope :find_active, -> (id) { 
    announcement = where(id: id, status: :active)
    raise ActiveRecord::RecordNotFound.new  "Couldn't find Announcement with 'id'=#{id}" if announcement.empty?
    return announcement&.first
  }
  validates :title, presence: :true, length: { minimum: 3, maximum: 300 }
  validates :description, length: { minimum: 3 }, allow_nil: true
  validate :validate_tag
  enum status: {
    active: 0,
    archived: 1,
  }

  def validate_tag
    accepted_tags = YAML.load_file("db/data/announcement_tags.yaml")
    if tags&.any? { |tag| accepted_tags.exclude? tag }
      errors.add(:tags, "should be an array of #{accepted_tags}".gsub(/[\/"]/, ""))
    end
  end
end
