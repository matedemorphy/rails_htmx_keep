# frozen_string_literal: true

class NoteComponent < ViewComponent::Base
  def initialize(id:, rich_content:, title:, image_key:, color:)
    @id = id
    @image_key = image_key
    @title = title
    @rich_content = rich_content
    @color = color
  end
end
