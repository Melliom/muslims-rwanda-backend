# frozen_string_literal: true

class AddIndexToNameMosque < ActiveRecord::Migration[5.2]
  def change
    add_index :mosques, :name, opclass: :gin_trgm_ops, using: :gin
  end
end
