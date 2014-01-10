CarrierWave.configure do |config|
  #config.fog_credentials = {
  #  :provider   => 'Local',
  #  :local_root => "#{Rails.root}/public/uploads/attachments"
  #}
  #config.fog_public     = false
  #config.fog_attributes = {}
  config.storage = :file
end
