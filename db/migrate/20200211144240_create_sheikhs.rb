# frozen_string_literal: true

class CreateSheikhs < ActiveRecord::Migration[5.2]
  def change
    create_table :sheikhs do |t|
      t.string :names
      t.string :tel
      t.string :address
      t.integer :role, default: 0
      t.string :language, default: "rw"
      t.string :avatar

      t.timestamps
    end
  end
end
