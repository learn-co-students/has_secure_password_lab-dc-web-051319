# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def require_login
    redirect_to '/login' unless session.include? :user_id
  end
end
