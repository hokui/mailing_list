class List < ActiveRecord::Base
  validates(:name) { presence; uniqueness }
end
