# == Schema Information
#
# Table name: attachments
#
#  id             :integer          not null, primary key
#  archive_id     :integer          not null
#  name           :string(255)      not null
#  type           :string(255)      not null
#  content_base64 :text             not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Attachment < ActiveRecord::Base
  belongs_to :archive

  validates(:name) { presence }
  validates(:type) { presence }
  validates(:content_base64) { presence }
end
