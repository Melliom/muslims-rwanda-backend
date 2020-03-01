# frozen_string_literal: true

class ChangeSheikhsTelToTelephone < ActiveRecord::Migration[5.2]
  def change
    rename_column :sheikhs, :tel, :telephone
  end
end
