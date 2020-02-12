# frozen_string_literal: true

class RemoveAvatarToSheikhs < ActiveRecord::Migration[5.2]
  def change
    remove_column :sheikhs, :avatar, :string
  end
end
