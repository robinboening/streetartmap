CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'
  config.fog_directory = Rails.configuration.aws_directory
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => Rails.configuration.aws_access_key_id,
    :aws_secret_access_key  => Rails.configuration.aws_secret_access_key,
    :region                 => 'eu-west-1',
    :endpoint               => 'https://s3-eu-west-1.amazonaws.com'
  }
end
