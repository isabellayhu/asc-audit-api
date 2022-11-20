# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :audit_template

  validates :title, presence: true
end
