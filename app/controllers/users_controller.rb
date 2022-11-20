# frozen_string_literal: true

class UsersController < ActionController::API
  def create
    @user = User.new(register_params)

    if @user.save
      # TODO: Return real JWT
      render json: { session: JsonWebToken.encode({ email: @user.email, id: @user.id }) }
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      render json: { session: JsonWebToken.encode({ email: @user.email, id: @user.id }) }
    else
      render json: { error: 'Incorrect email or password' }, status: :unauthorized
    end
  end

  private

  def register_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
