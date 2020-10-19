# frozen_string_literal: true

class RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_request, only: %i[show edit update destroy]

  def index
    @requests = current_user.super_admin? ? Request.all : Request.where(requested_by: current_user.id)
  end

  def create
    @request = Request.new(resource_params.merge(requested_by: current_user.id))
    @request.save
    @book = Book.find_by(id: resource_params[:book_id])
    @book.available -= 1 
    @book.save
    RequestMailer.notify_new_request(@book, @request, current_user).deliver
    flash[:notice] = 'book requested'
    redirect_to books_path
  end

  def update
    
  end

  private

  def resource_params
    params.require(:request).permit(:book_id, :times_renewed, :start_date, :end_date)
  end
end