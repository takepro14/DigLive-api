class AvatarUploader < CarrierWave::Uploader::Base

  if Rails.env.development?
    storage :file  # ローカルにアップロード
  elsif Rails.env.test?
    storage :file
  else
    storage :fog  # S3にアップロード
  end

  # 画像保存先パス
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # デフォルト画像
  def default_url(*args)
    "/uploads/#{model.class.to_s.underscore}/#{mounted_as}/default.png"
  end

end
