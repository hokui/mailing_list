# == Schema Information
#
# Table name: archives
#
#  id         :integer          not null, primary key
#  list_id    :integer          not null
#  parent_id  :integer
#  message_id :string(255)
#  number     :integer          not null
#  from       :string(255)      not null
#  subject    :string(255)      default(""), not null
#  text       :text             default(""), not null
#  html       :text             default(""), not null
#  raw        :text             default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :archive do
    list_id 1
    number  1
    from    "MyString"
    subject "MyString"
    text    "MyText"
    html    "MyText"
    raw     "MyText"
  end
end
