FactoryGirl.define do
  factory :archive do
    list_id 1
    number  1
    from    "MyString"
    subject "MyString"
    body    "MyText"
    raw     "MyText"
  end
end
