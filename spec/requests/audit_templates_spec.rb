require 'rails_helper'

RSpec.describe "AuditTemplates", type: :request do
  describe "#create" do
    it "creates a new audit template" do
      expect do
        post "/audit_templates", params: {audit_template: {name: "ASC 2022"}}
      end.to change { AuditTemplate.count }.by(1)
    end

    it "does not create a new audit template when name is null" do
      expect do
        post "/audit_templates", params: {audit_template: {name: ""}}
      end.to_not change { AuditTemplate.count }
      
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ "name" => ["can't be blank"] }) 
    end
  end

  describe "#update" do
    let(:name) { "ASC Old"}
    let!(:audit_template1) {FactoryBot.create(:audit_template, { name: name })}
    
    it "updates an existing template" do
      put "/audit_templates/#{audit_template1.id}", params: {audit_template: {name: "ASC New"}}
      audit_template1.reload

      expect(audit_template1.name).to eq ("ASC New")
    end

    it "returns error when audit template id not found" do
      put "/audit_templates/wrongid"
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "error" => "Audit template id not found" })
    end 
  end
end
