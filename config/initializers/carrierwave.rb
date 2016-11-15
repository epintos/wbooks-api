CarrierWave.configure do |config|
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = true
    config.root = "#{Rails.root}/tmp"
  else
    # Configuration for Amazon S3
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: Rails.application.secrets.aws_region,
      path_style: true
    }
    config.storage = :fog
    config.fog_use_ssl_for_aws = false
    config.fog_directory = Rails.application.secrets.aws_bucket_name
    config.fog_public = true
    config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
  end

  # To let CarrierWave work on heroku
  config.cache_dir = "#{Rails.root}/public/uploads"
end
