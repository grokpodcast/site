# Based on http://ixti.net/software/2013/01/28/using-jekyll-plugins-on-github-pages.html
require 'jekyll'
require 'tmpdir'
require 'fileutils'

module Tasks
  module Deploy
    module GithubPages
      extend FileUtils

      class TargetRepositoryNotConfigured < StandardError
        def initialize(msg = "Target repository to deploy to GitHub Pages isn't configured")
          super(msg)
        end
      end

      def self.config
        @config ||= Jekyll.configuration({})
      end

      def self.payload_directory
        config['destination']
      end

      def self.target_repository
        result = config['deploy']['github_pages']['target_repository']
        result.nil? ? raise : result
      rescue
        raise TargetRepositoryNotConfigured
      end

      def self.deploy
        Dir.mktmpdir do |tmp|
          cp_r payload_directory, tmp
          Dir.chdir tmp

          touch ".nojekyll"

          message = "Site updated at #{Time.now.utc}"
          system "git init"
          system "git add ."
          system "git commit -m #{message.shellescape}"
          system "git remote add origin git@github.com:#{target_repository}.git"
          system "git push origin master:refs/heads/gh-pages --force"
        end
      end
    end
  end
end