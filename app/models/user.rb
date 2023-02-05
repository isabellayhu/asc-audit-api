# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_confirmation, presence: true

  has_many :audit_templates
  accepts_nested_attributes_for :audit_templates
end
