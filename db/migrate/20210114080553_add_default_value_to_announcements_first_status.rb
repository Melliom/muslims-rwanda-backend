# frozen_string_literal: true

class AddDefaultValueToAnnouncementsFirstStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :announcements, :status, :integer, default: 0
  end
end
