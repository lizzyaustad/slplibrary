# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :check_permission

  def index
    @users = User.all
  end

  def show
    redirect_to root
  end

  def check_permission
    unless current_user.super_admin?
      flash[:notice] = 'Unauthorized'
      redirect_to books_path
    end
  end
end
