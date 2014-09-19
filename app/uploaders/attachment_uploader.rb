# encoding: utf-8
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mime_types'
class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    return Rails.env == "production" ? "prod/uploads" : "dev/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.asset_path([version_name, "default.jpg"].compact.join('_'))
  end

  version :thumb do
    process :resize_to_fit => [100, 10000]
  end

  version :standard_size do
    process :resize_to_limit => [600, 10000]
  end

  version :display_size do
    process :resize_to_limit => [300, 10000]
  end

  process :set_content_type

  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end

  def filename
    #"#{Time.now.to_i}.png"
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end

end
