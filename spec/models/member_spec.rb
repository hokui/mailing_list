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

require 'rails_helper'

RSpec.describe Member, :type => :model do
  describe "validation" do
    it "ensures uniqueness between email/email_sub, while allowing email_sub to be blank" do
      Member.create(name: "1", email: "1@example.com")                             # OK
      Member.create(name: "2", email: "2@example.com")                             # OK
      Member.create(name: "3", email: "3@example.com", email_sub: "3@example.net") # OK

      Member.create(name: "4", email: "4@example.com", email_sub: "3@example.com") # Bad
      Member.create(name: "5", email: "3@example.net", email_sub: "5@example.net") # Bad
      Member.create(name: "6", email: "3@example.com", email_sub: "6@example.net") # Bad
      Member.create(name: "7", email: "7@example.com", email_sub: "3@example.net") # Bad

      expect(Member.pluck(:name)).to eq(["1", "2", "3"])
    end
  end
end
