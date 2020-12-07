# frozen_string_literal: true

class AddArchivedToMosques < ActiveRecord::Migration[5.2]
  def change
    add_column :mosques, :archived, :boolean, default: false
  end
end
