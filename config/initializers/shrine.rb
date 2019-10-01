require "shrine"
require "shrine/storage/s3"

s3_options = {
    access_key_id:      Krated.credentials.dig(:aws, :access_key_id),
    secret_access_key:  Krated.credentials.dig(:aws, :secret_access_key),
    region:             Krated.credentials.dig(:aws, :region),
    bucket:             Krated.credentials.dig(:aws, :s3_bucket)
}

if Rails.env.development?
  require "shrine/storage/file_system"
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")  # permanent
  }
elsif Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require "shrine/storage/s3"

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "#{Rails.env.to_sym}/cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "#{Rails.env.to_sym}/store", **s3_options)
  }
end
Shrine.plugin :activerecord # or :activerecord
Shrine.plugin :cached_attachment_data
