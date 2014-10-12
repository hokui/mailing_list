# == Schema Information
#
# Table name: attachments
#
#  id             :integer          not null, primary key
#  archive_id     :integer          not null
#  name           :string(255)      not null
#  mime           :string(255)      not null
#  is_image       :boolean
#  content_base64 :text             not null
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe Attachment, :type => :model do
end
