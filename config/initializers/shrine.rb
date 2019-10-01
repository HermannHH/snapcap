require "shrine"
require "shrine/storage/s3"

s3_options = {
    access_key_id:      ENV.fetch("AWS_ACCESS_KEY_ID") { "" },
    secret_access_key:  ENV.fetch("AWS_SECRET_ACCESS_KEY") { "" },
    region:             ENV.fetch("AWS_REGION") { "" },
    bucket:             ENV.fetch("AWS_S3_BUCKET") { "" }
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
