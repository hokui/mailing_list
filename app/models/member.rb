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

class Member < ActiveRecord::Base
  has_and_belongs_to_many :lists

  validates(:name)  { presence }
  validates(:email) { presence }
  validate :uniqueness_between_email_and_email_sub

  def Member.find_from_existing_emails(email)
    Member.find_by(email: email) || Member.find_by(email_sub: email)
  end

  private

  def uniqueness_between_email_and_email_sub
    emails = Member.pluck(:email, :email_sub).flatten.select { |e| !e.blank? }
    errors.add(:email, "has already been taken") if emails.include?(email)
    errors.add(:email_sub, "has already been taken") if emails.include?(email_sub)
  end
end
