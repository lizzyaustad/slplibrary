# frozen_string_literal: true
# == Schema Information
#
# Table name: books
#
#  id             :bigint(8)        not null, primary key
#  title          :string(255)      not null
#  author         :string(255)      not null
#  description    :text(65535)
#  quantity       :integer          default(1), not null
#  lent_by        :string(255)      not null
#  checked_out_by :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  isbn           :string(255)
#  thumbnail      :string(255)
#  available      :integer
#

class Book < ApplicationRecord
  require 'open-uri'

  before_save :fill_empty_values

  def lent_by_user
    User.find_by(id: lent_by)
  end

  def borrowed_by_user
    User.find_by(id: borrowed_by)
  end

  def fill_empty_values
    return unless isbn && [thumbnail, title, author, description].include?(nil)
    more_info = Nokogiri::HTML(URI.open("https://openlibrary.org/isbn/#{isbn}"))
    self.thumbnail ||= "http://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg"
    self.title = more_info.xpath('//h1[@class="work-title"]').text.strip unless title.present?
    self.author = more_info.xpath('//h2[@class="edition-byline"]/a').text.strip unless author.present?
    self.description = more_info.xpath('//div[contains(@class, "book-description-content")]').text.strip unless description.present?
  end
end
