# frozen_string_literal: true

class Test < ApplicationRecord
  validates :title, presence: true
end
