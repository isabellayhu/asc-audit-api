# frozen_string_literal: true

require 'rails_helper'

describe 'JsonWebToken' do
  describe '.encode' do
    it 'encodes a JWT with correct expiry' do
      expiry = 24.hours.from_now
      payload = { email: 'john.doe@test.com', name: 'John Doe', id: 1 }

      expected_result = JWT.encode({
                                     email: 'john.doe@test.com',
                                     name: 'John Doe',
                                     id: 1,
                                     exp: expiry.to_i
                                   }, Rails.application.secrets.secret_key_base.to_s)

      jwt = JsonWebToken.encode(payload, expiry)

      expect(jwt).to eq(expected_result)
    end
  end

  describe '.decode' do
    it 'decodes a JWT' do
      token = 'eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImphbmUuZG9lQHRlc3QuY29tIiwibmFtZSI6IkphbmUgRG9lIiwiZXhwIjoxNjY4NDE3NzI0fQ.R4apKuGPGw4aUfrJC6YAghcChAPkhwpuAfG327UDPak'
      decoded = JsonWebToken.decode(token, false)

      result = {
        email: 'jane.doe@test.com',
        name: 'Jane Doe',
        exp: 1_668_417_724
      }.with_indifferent_access

      expect(decoded).to eq(result)
    end
  end
end
