require 'aws-sdk'

module Tasks
  module Deploy
    module S3
      def self.aws_credentials
        { access_key_id: 'AKIAJTUJGOUJAPL6NWAQ',
          secret_access_key: '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'}
      end

      def self.s3
        return @s3 unless @s3.nil?

        AWS.config(aws_credentials)
        @s3 = AWS::S3.new
      end

      def self.files_to_deploy
        everything = Dir.glob('_site/**/*')
        only_files = everything.select {|object| File.file?(object) }
      end

      def self.files_from_bucket(bucket)
        result = {}
        bucket.objects.each do |object|
          result[object.key] = object.etag.delete("\"")
        end
        result
      end

      def self.deploy
        files = files_to_deploy
        stats = { processed:  files.count,
                  copied:     0,
                  skipped:    0,
                  deleted:    0 }

        puts "loading remote file information..."
        target_bucket = s3.buckets['test_rake']
        remote_files = files_from_bucket(target_bucket)

        files.each do |file|
          puts "processing #{file}"
          if remote_files[file]
            skip_copy = remote_files[file] == Digest::MD5.file(file).hexdigest
            remote_files.delete file
          end

          unless skip_copy
            stats[:copied] += 1
            puts "copying #{file}"
            s3_object = target_bucket.objects[file]
            s3_object.write Pathname.new(file)
          else
            stats[:skipped] += 1
            puts "skipping #{file}"
          end
        end

        remote_files.each_key do |file|
          stats[:deleted] += 1
          puts "removing dangling file #{file}"
          dangling_file = target_bucket.objects[file]
          dangling_file.delete
        end

        puts "=============="
        puts "Summary:"
        puts "Files processed: #{stats[:processed]}"
        puts "Files copied: #{stats[:copied]}"
        puts "Files skipped: #{stats[:skipped]}"
        puts "Files deleted: #{stats[:deleted]}"
      end
    end
  end
end