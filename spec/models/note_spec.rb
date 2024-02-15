require "rails_helper"

RSpec.describe Note, type: :model do
  describe "validations" do
    it { should have_rich_text(:content) }
    it { should have_one_attached(:image) }
    it { should belong_to(:user) }
  end

  describe "active storage validations" do
    context "has_one_attached :image" do
      it { should have_one_attached(:image) }
    end

    context "#valid_image" do
      let(:note_with_oversize_image) { create(:note, :with_oversize_image) }
      let(:note_with_invalid_file_format) { create(:note, :with_invalid_file_format) }

      it "adds an error if image image size is greater than defined byte_size" do
        expect(note_with_oversize_image.errors).not_to be_empty
      end

      it "adds an error if file format is invalid" do
        expect(note_with_invalid_file_format.errors).not_to be_empty
      end
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
