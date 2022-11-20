# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register', type: :request do
  describe 'POST /register' do
    context 'validations fail' do
      it 'does not register a user if first name is missing' do
        post '/register', params: {
          user: {
            last_name: 'Doe',
            email: 'john.doe@test.com',
            password: 'secret',
            password_confirmation: 'secret'
          }
        }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'first_name' => ["can't be blank"] })
      end

      it 'does not register a user if last name is missing' do
        post '/register', params: {
          user: {
            first_name: 'John',
            email: 'john.doe@test.com',
            password: 'secret',
            password_confirmation: 'secret'
          }
        }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'last_name' => ["can't be blank"] })
      end

      it 'does not register a user if email is missing' do
        post '/register', params: {
          user: {
            first_name: 'John',
            last_name: 'Doe',
            password: 'secret',
            password_confirmation: 'secret'
          }
        }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'email' => ["can't be blank"] })
      end

      it 'does not register a user if passwords do not match' do
        post '/register', params: {
          user: {
            first_name: 'John',
            last_name: 'Doe',
            email: 'john.doe@test.com',
            password: 'secret',
            password_confirmation: 'secret1'
          }
        }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'password_confirmation' => ["doesn't match Password"] })
      end

      it 'does not register a user if email is already used' do
        FactoryBot.create(:user)

        expect do
          post '/register', params: {
            user: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'john.doe@test.com',
              password: 'secret',
              password_confirmation: 'secret'
            }
          }
        end.not_to change(User, :count)

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'email' => ['has already been taken'] })
      end
    end

    context 'validations pass' do
      it 'registers a user when no validation errors' do
        expect do
          post '/register', params: {
            user: {
              first_name: 'Jane',
              last_name: 'Doe',
              email: 'jane.doe@test.com',
              password: 'secret',
              password_confirmation: 'secret'
            }
          }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['session']).to be_truthy
      end
    end
  end
end

RSpec.describe 'Login', type: :request do
  describe 'POST /login' do
    let(:email) { 'realuser@test.com' }

    before do
      FactoryBot.create(:user, { email: email })
    end

    context 'failed login' do
      it 'login fails if email adress not found' do
        post '/login', params: {
          email: 'wrongemail@test.com',
          password: 'secret'
        }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq('error' => 'Incorrect email or password')
      end

      it 'login fails if password not correct' do
        post '/login', params: {
          email: 'realuser@test.com',
          password: 'wrongpassword'
        }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Incorrect email or password' })
      end
    end

    context 'successful login' do
      it 'registers a user when no validation errors' do
        post '/login', params: {
          email: 'realuser@test.com',
          password: 'secret'
        }
        expect(JSON.parse(response.body)['session']).to be_truthy
      end
    end
  end
end
