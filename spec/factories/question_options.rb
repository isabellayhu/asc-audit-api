FactoryBot.define do
  factory :question_option do
    position { 0 }
    description { "MyString" }
    grade { false }
    question { "" }
  end
end
