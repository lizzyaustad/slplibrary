# == Schema Information
#
# Table name: requests
#
#  id            :bigint(8)        not null, primary key
#  requested_by  :string(255)      not null
#  book_id       :string(255)      not null
#  times_renewed :integer          default(0), not null
#  start_date    :datetime         not null
#  end_date      :datetime         not null
#  created_at    :datetime
#  updated_at    :datetime
#  status        :string(255)      default("pending")
#

class Request < ApplicationRecord
  before_save :fill_dates

  def fill_dates
    self.start_date ||= Date.today
    self.end_date ||= 3.weeks.from_now
    self.times_renewed ||= 0
  end
end
