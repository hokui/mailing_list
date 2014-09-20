class Member < ActiveRecord::Base
  validates(:name)      { presence }
  validates(:email)     { presence; uniqueness(scope: :email_sub) }
  validates(:email_sub) {           uniqueness(scope: :email, allow_blank: true) }
end
