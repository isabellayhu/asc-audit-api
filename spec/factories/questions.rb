# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'MyString' }
    description { 'MyString' }
    photo_url { 'MyString' }
    audit_template { nil }
  end
end
