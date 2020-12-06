# frozen_string_literal: true

class AddRelationshipMosqueSheikh < ActiveRecord::Migration[5.2]
  def change
    add_reference :sheikhs, :mosque, foreign_key: true
  end
end
