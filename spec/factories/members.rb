# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  email_sub  :string(255)      default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :member do
    name "hoge fuga"
    email "hoge@example.com"
    email_sub "fuga@example.com"
  end
end
