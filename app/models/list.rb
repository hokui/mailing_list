# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class List < ActiveRecord::Base
  has_many :archives
  has_and_belongs_to_many :members

  validates(:name) { presence; uniqueness }

  def next_number
    if self.archives.count > 0
      self.archives.last.number + 1
    else
      1
    end
  end

  def to
    # TODO enable members to choose :email or :email_sub

    self.members.pluck(:email, :email_sub, :name).map { |email, email_sub, name| ["#{name} <#{email}>", "#{name} <#{email_sub}>"]}.flatten
  end

  def header_id
    "<#{self.name}.ml.hokui.net>"
  end
end
