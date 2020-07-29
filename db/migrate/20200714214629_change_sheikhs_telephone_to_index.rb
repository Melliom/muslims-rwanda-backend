# frozen_string_literal: true

class ChangeSheikhsTelephoneToIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :sheikhs, :telephone, opclass: :gin_trgm_ops, using: :gin
  end
end
