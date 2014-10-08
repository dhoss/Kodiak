CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => '',                        # required
    :aws_secret_access_key  => ''                        # required
  }  
  config.fog_directory  = Rails.env == "production" ? "stonecold-prod-images" : "stonecold-dev-images"                     # required
  config.fog_public     = false                                   # optional, defaults to true
 # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  
end
