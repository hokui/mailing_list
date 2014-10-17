# == Schema Information
#
# Table name: archives
#
#  id         :integer          not null, primary key
#  list_id    :integer          not null
#  parent_id  :integer
#  message_id :string(255)
#  number     :integer          not null
#  from       :string(255)      not null
#  subject    :string(255)      default(""), not null
#  text       :text             default(""), not null
#  html       :text             default(""), not null
#  raw        :text             default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

class Archive < ActiveRecord::Base
  belongs_to :list
  belongs_to :parent, class_name: "Archive"
  has_many :children, class_name: "Archive", foreign_key: "parent_id"
  has_many :attachments

  validates(:number)     { presence }
  validates(:from)       { presence }
  validates(:subject)    { presence }
  validates(:text)       { presence }
  validates(:raw)        { presence }
end
