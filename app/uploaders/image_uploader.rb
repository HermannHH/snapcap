class ImageUploader < Shrine

  plugin :activerecord
  plugin :determine_mime_type
  plugin :logging, logger: Rails.logger
  plugin :remove_attachment
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions
  plugin :processing

  Attacher.validate do
    validate_max_size 4.megabytes, message: 'is too large (max is 4 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  end

  process(:store) do |io, context|
    original = io.download
    pipeline = ImageProcessing::MiniMagick.source(original)

    social = pipeline.resize_to_limit!(1200, 628)
    card_cover = pipeline.resize_to_limit!(350, 350)
    thumb    = pipeline.resize_to_limit!(200, 200)

    original.close!

    { original: io, social: social, thumb: thumb, card_cover: card_cover }
  end

  def generate_location(io, context = {})
    # return "" unless context[:record].fileable
    # fileable_type = context[:record].fileable_type
    name  = super
    # if fileable_type == "Offering"
      
    # elsif fileable_type == "Company"
    #   route = [context[:record].fileable.slug, "logos",  name].compact.join("/")
    # end
    # route
    # route = [ context[:record].fileable.token,  name ].compact.join("/")

    # route
    name
  end

end
