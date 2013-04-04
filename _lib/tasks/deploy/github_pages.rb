# Based on http://ixti.net/software/2013/01/28/using-jekyll-plugins-on-github-pages.html

require 'tmpdir'

module Tasks
  module Deploy
    module GithubPages
      GITHUB_REPONAME = "grokpodcast/site"

      def self.deploy
        Dir.mktmpdir do |tmp|
          cp_r "_site/.", tmp
          Dir.chdir tmp
          system "git init"
          touch ".nojekyll"
          system "git add ."
          message = "Site updated at #{Time.now.utc}"
          system "git commit -m #{message.shellescape}"
          system "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
          system "git push origin master:refs/heads/gh-pages --force"
        end
      end
    end
  end
end