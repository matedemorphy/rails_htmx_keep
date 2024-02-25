# frozen_string_literal: true

class SearchComponentPreview < ViewComponent::Preview
  def default
    render(SearchComponent.new(search: "search"))
  end
end
