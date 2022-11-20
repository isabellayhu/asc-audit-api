class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_current_user, :authenticate

  attr_reader :current_user

  def set_current_user
    @current_user ||= authenticate_with_http_token do |token, _options|
      decoded = JsonWebToken.decode(token)
      User.find_by(id: decoded[:id])
    end
  end

  def authenticate
    head :unauthorized unless @current_user.present? 
  end
end
