Attachment.all.each do |a| 
  begin
   # a.process_your_uploader_upload = true # only if you use carrierwave_backgrounder
    a.attachment.cache_stored_file! 
    a.attachment.retrieve_from_cache!(a.your_uploader.cache_name) 
    a.attachment.recreate_versions! 
    a.save! 
  rescue => e
    puts  "ERROR: Attachment: #{a.id} -> #{e.to_s}"
  end
end
