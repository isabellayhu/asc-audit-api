require 'rails_helper'

RSpec.describe QuestionOption, type: :model do
  it { is_expected.to validate_presence_of(:position) }
  # it { is_expected.to validate_uniqueness_of(:position).scoped_to(:question_id) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:grade) }
end
