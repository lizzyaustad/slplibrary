# frozen_string_literal: true

class RequestMailer < ApplicationMailer
  default from: ENV['FROM_EMAIL']

  def notify_new_request(book, request, user)
    @book = book
    @request = request
    @user = user
    mail(to: @user.FROM_EMAIL, subject: 'Book has been requested')
  end
end
