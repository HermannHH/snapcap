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

  has_secure_token

  # mount_uploader :attachment, FileStoreUploader
  include ImageUploader::Attachment.new(:attachment)  # ImageUploader will attach and manage `image`

  # Associations
  belongs_to :fileable, polymorphic: true

end
