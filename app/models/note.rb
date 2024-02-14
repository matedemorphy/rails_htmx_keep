class Note < ApplicationRecord
  has_rich_text :content
  has_one_attached :image

  validate :valid_image, if: -> { image.present? }

  private

  def valid_image
    unless image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:image, "must be a JPEG or PNG")
      return
    end

    unless image.blob.byte_size <= 1.megabytes
      errors.add(:image, "must be less than 2MB")
      nil
    end
  end
end

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  title      :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
