# frozen_string_literal: true

class NoteComponentPreview < ViewComponent::Preview
  # Card with all attributes

  # -@param color select { choices: [#FFFFFF, #FFFF00, #0000FF, #FF0000, #097969, #A020F0] }
  def with_all_attributes
    image_keys = [
      "ccl8qwjs4hcsulkfzbxr",
      "lyeltw1xayxsz5trzufk",
      "hvckrdwk7twwoebwlenc",
      "setgpkpq4ufqcdybdvcn",
      "wwrdbz628jxx7fdcq4rb",
      "ofyzfobpzzo9ajayhqzx",
      "piw4gjtrlfeebdxqn0gy",
      "kns057xn6eal9mooicji",
      "kprry9ogmiwwzmdkofkg",
      "huvb6axq1wr7amihsohp",
      "rrpzlpzwu7i9vvtdg2c9",
      "y0mexk0vam7hdxiyt8hv",
      "dvcnmqxggvw7ehxeqc67"
    ]
    id = Note.last.id
    title = Faker::Lorem.sentence(word_count: rand(1..3))
    rich_content = Faker::Lorem.paragraph(sentence_count: rand(1..12))
    image_key = image_keys.sample
    component = NoteComponent.new(id: id, rich_content: rich_content, title: title, image_key: image_key, color: "#FFFFFF")
    render(component)
  end
end
