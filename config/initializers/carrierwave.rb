require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  # 本番環境 => S3へアップロード
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'diglive-public-image' # バケット名
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['SECRET_ACCESS_KEY_ID'],
      region: 'ap-northeast-1',
      path_style: true
    }
  # 開発/テスト環境 => アプリケーション内にアップロード
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end