# frozen_string_literal: true

class Comment < ApplicationRecord
  include Commentable
  belongs_to :commentable, polymorphic: true, optional: false
  
  validates :content, presence: :true
end
