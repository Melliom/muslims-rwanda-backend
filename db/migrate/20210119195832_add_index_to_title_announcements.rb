# frozen_string_literal: true
class AddIndexToTitleAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_index :announcements, :title, opclass: :gin_trgm_ops, using: :gin
    add_index :announcements, :tags
  end
end
