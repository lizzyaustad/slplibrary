# frozen_string_literal: true

class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_book, only: %i[show edit update destroy]

  def index
    @books = Book.all.order('title asc')
  end

  def new
    unless current_user.super_admin?
      flash[:notice] = 'Unauthorized'
      redirect_to books_path
    end
    @book = Book.new
  end

  def create
    unless current_user.super_admin?
      flash[:notice] = 'Unauthorized'
      redirect_to books_path
    end
    @book = Book.new(resource_params)
    @book.lent_by = current_user.id
    @book.available = @book.quantity
    @book.save
    flash[:notice] = 'book created'
    redirect_to books_path
  end

  def show; end

  def edit; end

  def update
    unless current_user.super_admin?
      flash[:notice] = 'Unauthorized'
      redirect_to books_path
    end
    @book.update(resource_params)
    flash[:notice] = 'book updated'
    redirect_to books_path
  end

  def destroy
    unless current_user.super_admin?
      flash[:notice] = 'Unauthorized'
      redirect_to books_path
    end
    flash[:notice] = 'book removed' if @book.destroy
    redirect_to books_path
  end

  def search
    @books = book_search
    render 'search'
  end

  def random
    books = book_search
    if books.count.positive?
      book = books.to_a[rand(0..books.count - 1)]
      render js: "window.location = '#{book_path(book)}'"
    else
      flash[:notice] = 'None found. Please expand your search terms.'
      render js: "window.location = '#{books_path}'"
    end
  end

  private

  def resource_params
    params.require(:book).permit(:title, :author, :description, :quantity, :isbn)
  end

  def search_params
    params.require(:search).permit(:location, :duration, :outside, :name, :categories, :rating, categories: [], rating: [])
  end

  def book_search # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize
    books = Book.all
    books = books.where(location: search_params[:location]) if search_params[:location].present?
    books = categories_search(books) if search_params[:categories].present?
    books = books.where('name LIKE ?', "%#{search_params[:name]}%") if search_params[:name].present?
    books.order('rating desc')
  end

  def categories_search(books)
    matches = []
    books.where.not(categories: nil).each do |a|
      matches << a if (search_params[:categories] - a.categories).blank?
    end
    matches
  end

  def load_book
    @book = Book.find_by(id: params[:id])
  end
end
