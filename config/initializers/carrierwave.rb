require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|

  if Rails.env.production?
    config.storage :fog
    config.fog_provider     = 'fog/aws'
    config.fog_directory    = 'diglive-public-image'
    config.fog_public       = false
    config.fog_credentials  = {
      provider:               'AWS',
      aws_access_key_id:      ENV['ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['SECRET_ACCESS_KEY_ID'],
      region:                 'ap-northeast-1'
    }
  else
    config.asset_host         = ENV['IMAGE_URL']
    config.cache_storage      = :file
    config.enable_processing  = false if Rails.env.test?
  end
end