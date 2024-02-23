require "open-uri"

FactoryBot.define do
  factory :note do
    title { Faker::Lorem.sentence(word_count: rand(1..3)) }
    content { rand(1..3).times { Faker::Lorem.paragraph(sentence_count: rand(1..3)) } }
    user

    trait :with_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', 'note.jpg'), 'image/jpeg') }
    end

    trait :with_all_attributes do
      # after :create do |note|
      #   image_file = URI.parse(Faker::LoremFlickr.image(size: "400x400", search_terms: [[Faker::Emotion.adjective, Faker::Emotion.noun, Faker::Verb.base].sample])).open
      #   note.image.attach(io: image_file, filename: "#{Faker::Commerce.promotion_code(digits: 5).downcase}.jpg")
      # end
    end

    trait :invalid do
      content { nil }
    end

    trait :with_oversize_image do
      after :create do |note|
        image_file = URI.parse("https://res.cloudinary.com/josephcloudinary1/image/upload/v1707866697/htmx_rails_keep/vovipku5vd18mksdjm07.jpg").open
        note.image.attach(io: image_file, filename: "#{Faker::Commerce.promotion_code(digits: 5).downcase}.jpg")
      end
    end

    trait :with_invalid_file_format do
      after :create do |note|
        invalid_file = URI.parse("https://res.cloudinary.com/josephcloudinary1/image/upload/v1707893064/htmx_rails_keep/ln8btrnzcg7i4hcvnkec.webp").open
        note.image.attach(io: invalid_file, filename: "#{Faker::Commerce.promotion_code(digits: 5).downcase}.webp")
      end
    end
  end
end

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  color      :string           default("#ffffff")
#  title      :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_notes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
