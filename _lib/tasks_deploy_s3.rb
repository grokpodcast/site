require 'aws-sdk'

module Tasks
  module Deploy
    def self.deploy_s3
      credentials = {access_key_id: 'A', secret_access_key: 'B'}

      AWS.config(credentials)
      s3 = AWS::S3.new

      Dir.chdir('_site')
      everything = Dir.glob('**/*')
      only_files = everything.select {|object| File.file?(object) }

      target_bucket = s3.buckets['test_rake']

      puts "loading remote file information..."
      target_existing_files = {}
      target_bucket.objects.each do |object|
        target_existing_files[object.key] = object.etag.delete("\"")
      end

      files_to_process = only_files.count
      files_copied = 0
      files_skept = 0
      files_deleted = 0

      only_files.each do |file|
        puts "processing #{file}"
        if target_existing_files[file]
          skip_copy = target_existing_files[file] == Digest::MD5.file(file).hexdigest
          target_existing_files.delete file
        end

        unless skip_copy
          files_copied += 1
          puts "copying #{file}"
          s3_object = target_bucket.objects[file]
          s3_object.write Pathname.new(file)
        else
          files_skept += 1
          puts "skipping #{file}"
        end
      end

      target_existing_files.each_key do |file|
        files_deleted += 1
        puts "removing dangling file #{file}"
        dangling_file = target_bucket.objects[file]
        dangling_file.delete
      end

      puts "=============="
      puts "Summary:"
      puts "Files processed: #{files_to_process}"
      puts "Files copied: #{files_copied}"
      puts "Files skept: #{files_skept}"
      puts "Files deleted: #{files_deleted}"
    end
  end
end