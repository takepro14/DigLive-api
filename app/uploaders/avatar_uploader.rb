class AvatarUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    if Rails.env.production?
      "https://diglive-public-image.s3.amazonaws.com/uploads/#{model.class.to_s.underscore}/#{mounted_as}/default.png"
    else
      "#{ENV['IMAGE_URL']}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/default.png"
    end
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end

end
