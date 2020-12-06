# frozen_string_literal: true

class CreateMosques < ActiveRecord::Migration[5.2]
  def change
    create_table :mosques do |t|
      t.string :name
      t.decimal :lng, precision: 10, scale: 6
      t.decimal :lat, precision: 10, scale: 6
      t.integer :size, default: 0
      t.string :momo_number
      t.string :address
      t.string :cashpower

      t.timestamps
    end
  end
end
