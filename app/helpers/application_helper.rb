# frozen_string_literal: true

module ApplicationHelper
  def active_link_to(text = nil, path = nil)
    active = path == request.path ? 'active' : ''
    content_tag :span, class: active + ' nav-item' do
      link_to(text, path)
    end
  end
end
