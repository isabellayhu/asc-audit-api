# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :audit_template
  has_many :question_options
  accepts_nested_attributes_for :question_options

  validates :title, presence: true
end
