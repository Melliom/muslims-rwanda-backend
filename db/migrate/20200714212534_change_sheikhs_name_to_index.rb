# frozen_string_literal: true

class ChangeSheikhsNameToIndex < ActiveRecord::Migration[5.2]
  def change
    enable_extension :pg_trgm

    add_index :sheikhs, :names, opclass: :gin_trgm_ops, using: :gin
  end
end
