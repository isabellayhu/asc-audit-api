class UsersController < ApplicationController
  def create
    @user = User.new(register_params)

    if @user.save
      # TODO: Return real JWT
      render json: { session: { jwt: "dummy token" } }
    else
      render json: @user.errors, status: :bad_request
    end
  end

  private

  def register_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
