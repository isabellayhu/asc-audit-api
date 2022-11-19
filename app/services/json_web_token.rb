class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end
  
  def self.decode(token, verify = true)
    decoded = JWT.decode(token, SECRET_KEY, verify, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new decoded
  end
end