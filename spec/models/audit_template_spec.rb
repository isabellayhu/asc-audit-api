require 'rails_helper'

RSpec.describe AuditTemplate, type: :model do
  it { should validate_presence_of(:name) }
end
