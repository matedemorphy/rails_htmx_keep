class Note < ApplicationRecord
  attr_accessor :content_plain_text

  include PgSearch::Model

  pg_search_scope :search_full_text,
    against: :title,
    associated_against: {
      action_text_rich_text: :body
    }

  belongs_to :user
  has_rich_text :content
  has_one :action_text_rich_text,
    class_name: "ActionText::RichText",
    as: :record
  has_one_attached :image do |attachable|
    attachable.variant :card, resize_to_limit: [200, 200]
  end

  validate :valid_image, if: -> { image.present? }
  validates :content, presence: true
  scope :current_user, ->(user_id) { where(user_id: user_id).order(created_at: :asc) }

  def content_plain_text
    content.body&.to_plain_text || ""
  end

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
