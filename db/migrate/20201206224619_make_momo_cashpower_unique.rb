# frozen_string_literal: true

class MakeMomoCashpowerUnique < ActiveRecord::Migration[5.2]
  def change
    change_column :mosques, :momo_number, :string, unique: true
    change_column :mosques, :cashpower, :string, unique: true
  end
end
