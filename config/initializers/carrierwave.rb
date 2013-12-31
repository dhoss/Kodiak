CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider   => 'Local',
    :local_root => '~/fog'
  }
  config.fog_directory  = "attachments"
  config.fog_public     = false
  config.fog_attributes = {}
end
