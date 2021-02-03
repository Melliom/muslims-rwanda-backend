# frozen_string_literal: true

class Comment < ApplicationRecord
  include Commentable
  belongs_to :commentable, polymorphic: true, optional: false
  scope :threads, -> (resource) { where(is_thread: true, commentable: resource)}
  scope :non_threads, -> { where(is_thread: false)}
  
  validates :content, presence: :true
end
