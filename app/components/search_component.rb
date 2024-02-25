# frozen_string_literal: true

class SearchComponent < ViewComponent::Base
  def initialize(search:)
    @search = search
  end
end
