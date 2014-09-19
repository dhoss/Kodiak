CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJ7JTOFLAOTFSS4VA',                        # required
    :aws_secret_access_key  => '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'                        # required
  }  
  config.fog_directory  = Rails.env == "production" ? "stonecold-prod-images" : "stonecold-dev-images"                     # required
  config.fog_public     = false                                   # optional, defaults to true
 # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  
end
