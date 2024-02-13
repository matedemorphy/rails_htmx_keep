FactoryBot.define do
  factory :note do
    title { "MyString" }
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
