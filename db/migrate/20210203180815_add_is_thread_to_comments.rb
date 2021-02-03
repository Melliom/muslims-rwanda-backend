# frozen_string_literal: true
class AddIsThreadToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :is_thread, :boolean, default: false, index: true
  end
end
