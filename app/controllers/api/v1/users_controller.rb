class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :set_user, except: :create

  def show
    respond_with @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: {errors: user.errors}, status: 422
    end
  end

  def update
    if @user.update user_params
      render json: @user, status: 200, location: [:api, @user]
    else
      render json: {errors: @user.errors}, status: 422
    end
  end

  def destroy
    if @user.delete
      render json: {}, status: 204
    else
      render json: {errors: @user.errors}, status: 422
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find params[:id]
  end
end
