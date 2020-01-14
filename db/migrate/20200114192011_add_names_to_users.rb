# frozen_string_literal: true

class AddNamesToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :names
      t.string :sex
    end
  end
end
