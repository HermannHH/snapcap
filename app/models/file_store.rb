# == Schema Information
#
# Table name: file_stores
#
#  id              :integer          not null, primary key
#  fileable_type   :string
#  fileable_id     :integer
#  attachment_data :jsonb
#  token           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class FileStore < ApplicationRecord
end
