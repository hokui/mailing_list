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
end
