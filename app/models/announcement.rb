# frozen_string_literal: true

class Announcement < ApplicationRecord
  validates :title, presence: :true, length: { minimum: 3, maximum: 300 }
  validates :description, length: { minimum: 3 }, allow_nil: true
  validate :validate_tag
  enum status: {
    active: 0,
    archived: 1,
  }

  def validate_tag
    accepted_tags = YAML.load_file("db/data/announcement_tags.yaml")
    if !tags.is_a?(Array) || tags.any? { |tag| accepted_tags.exclude? tag }
      errors.add(:tags, "should be one of #{accepted_tags}".gsub(/[\/"]/, ""))
    end
  end
end
