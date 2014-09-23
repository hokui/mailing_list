class List < ActiveRecord::Base
  has_many :archives
  has_and_belongs_to_many :members

  validates(:name) { presence; uniqueness }
end
