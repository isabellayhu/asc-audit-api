# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AuditTemplates', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:token) { JsonWebToken.encode({ email: user.email, id: user.id }) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe '#create' do
    it 'creates a new audit template' do
      expect do
        post '/audit_templates', headers: headers, params: { audit_template: { name: 'ASC 2022' } }
      end.to change(AuditTemplate, :count).by(1)
    end

    it 'does not create a new audit template when name is null' do
      expect do
        post '/audit_templates', headers: headers, params: { audit_template: { name: '' } }
      end.not_to change(AuditTemplate, :count)

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ 'name' => ["can't be blank"] })
    end

    it 'creates a audit template with question' do
      expect do
        post '/audit_templates', headers: headers, params: {
          audit_template: {
            name: 'ASC 2022',
            questions_attributes: [
              {
                title: 'Question 1'
              },
              {
                title: 'Question 2',
                description: 'something',
                photo_url: 'something'
              }
            ]
          }
        }
      end.to change(AuditTemplate, :count).by(1)
                                          .and change(Question, :count).by(2)
    end

    it 'does not create a audit template with question when title missing' do
      expect do
        post '/audit_templates', headers: headers, params: {
          audit_template: {
            name: 'ASC 2022',
            questions_attributes: [
              {
                title: ''
              }
            ]
          }
        }
      end.not_to change(AuditTemplate, :count)

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ 'questions.title' => ["can't be blank"] })
    end
  end

  describe '#update' do
    let(:name) { 'ASC Old' }
    let(:title) { 'Question Old' }
    let!(:question1) { FactoryBot.create(:question, { title: title, audit_template: audit_template1 }) }
    let!(:audit_template1) { FactoryBot.create(:audit_template, { name: name, user: user }) }

    it 'updates an existing template' do
      put "/audit_templates/#{audit_template1.id}", headers: headers, params: { audit_template: { name: 'ASC New' } }
      audit_template1.reload

      expect(audit_template1.name).to eq('ASC New')
    end

    it 'returns error when audit template id not found' do
      put '/audit_templates/wrongid', headers: headers

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Audit template id not found' })
    end

    it 'does not update the template when new name is null' do
      expect do
        put "/audit_templates/#{audit_template1.id}", headers: headers, params: { audit_template: { name: '' } }
      end.not_to change(audit_template1, :name)

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ 'name' => ["can't be blank"] })
      expect(audit_template1.name).to eq('ASC Old')
    end

    it 'updates the question in a template' do
      put "/audit_templates/#{audit_template1.id}", headers: headers, params: {
        audit_template: {
          questions_attributes: [
            { id: question1.id, title: 'Question New' }
          ]
        }
      }
      audit_template1.reload

      expect(audit_template1.questions.first.title).to eq('Question New')
    end

    it 'does not updates the question in a template when new title is null' do
      expect do
        put "/audit_templates/#{audit_template1.id}", headers: headers, params: {
          audit_template: {
            questions_attributes: [
              { id: question1.id, title: '' }
            ]
          }
        }
      end.not_to change(audit_template1.questions.first, :title)

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ 'questions.title' => ["can't be blank"] })
      expect(audit_template1.questions.first.title).to eq('Question Old')
    end
  end

  describe '#destroy' do
    let(:name) { 'ASC Old' }
    let!(:audit_template1) { FactoryBot.create(:audit_template, { name: name, user: user }) }

    it 'deletes an existing template' do
      expect do
        delete "/audit_templates/#{audit_template1.id}", headers: headers
      end.to change(AuditTemplate, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns error when audit template id not found' do
      delete '/audit_templates/wrongid', headers: headers

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Audit template id not found' })
    end
  end
end
