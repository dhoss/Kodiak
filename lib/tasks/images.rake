namespace :images do
  desc "reprocess images"
  task :reprocess => :environment do
    puts "Beginning image reprocessings"
    Attachment.find_each do |i|
      puts "Started #{i.name}"
      i.attachment.cache_stored_file!
      i.attachment.retrieve_from_cache!(i.attachment.cache_name)
      i.attachment.recreate_versions! 
      i.save! 
      puts "Finished #{i.name}"
    end 
  end
end
