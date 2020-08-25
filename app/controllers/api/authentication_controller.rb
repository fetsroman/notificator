class Api::AuthenticationController < ApplicationController
  def sign_up
    @user = User.new(email: user_params[:email], password: user_params[:password])
    if @user.save
      token = JsonWebToken.encode({user_id: @user.id, exp: 1.month.from_now.to_i })

      render json: { token: token, user: @user }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # POST /sign_in
  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      token = JsonWebToken.encode({user_id: @user.id, exp: 1.month.from_now.to_i })

      render json: { token: token, user: @user }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
