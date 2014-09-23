# == Schema Information
#
# Table name: archives
#
#  id         :integer          not null, primary key
#  list_id    :integer          not null
#  number     :integer          not null
#  from       :string(255)      not null
#  subject    :string(255)      default(""), not null
#  body       :text             default(""), not null
#  raw        :text             default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

class Archive < ActiveRecord::Base
  belongs_to :list

  validates(:number)  { presence }
  validates(:from)    { presence }
  validates(:subject) { presence }
  validates(:body)    { presence }
  validates(:raw)     { presence }
end
