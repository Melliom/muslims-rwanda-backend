# frozen_string_literal: true

class AddTagsToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :tags, :string, index: true, array: true
  end
end
