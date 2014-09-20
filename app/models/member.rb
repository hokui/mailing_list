class Member < ActiveRecord::Base
  has_and_belongs_to_many :lists

  validates(:name)  { presence }
  validates(:email) { presence }
  validate :uniqueness_between_email_and_email_sub

  private

  def uniqueness_between_email_and_email_sub
    emails = Member.pluck(:email, :email_sub).flatten.select { |e| !e.blank? }
    errors.add(:email, "has already been taken") if emails.include?(email)
    errors.add(:email_sub, "has already been taken") if emails.include?(email_sub)
  end
end
