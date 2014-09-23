class Archive < ActiveRecord::Base
  belongs_to :list

  validates(:number)  { presence }
  validates(:from)    { presence }
  validates(:subject) { presence }
  validates(:body)    { presence }
  validates(:raw)     { presence }
end
