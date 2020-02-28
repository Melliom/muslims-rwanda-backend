# frozen_string_literal: true

class AddStatusToSheikhs < ActiveRecord::Migration[5.2]
  def change
    add_column :sheikhs, :status, :integer, default: 0
  end
end
