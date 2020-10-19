# frozen_string_literal: true

module ActivitiesHelper
  def categories
    @categories ||= %w[movie tv hike food travel pet-friendly escape-room road-trip project learning exercise game volunteer other]
  end

  def duration_options
    @duration_options ||= ['evening', 'morning', 'full day', 'weekend', 'long weekend', 'week', 'ongoing']
  end

  def location_options
    @location_options ||= Activity.all.pluck(:location).map(&:downcase).uniq
  end

  def ratings
    @ratings ||= [1, 2, 3, 4, 5]
  end
end
