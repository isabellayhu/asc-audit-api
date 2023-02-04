class QuestionOption < ApplicationRecord
    belongs_to :question

    validates :position, presence: true, uniqueness: { scope: :question_id }
    validates :description, presence: true
    validates :grade, presence: true
end
