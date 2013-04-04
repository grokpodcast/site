require_relative '_lib/tasks_generate'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => ['site:generate']

namespace :site do
  desc "Generate blog files"
  task :generate do
    Tasks.generate
  end

  desc "Generate and publish blog to gh-pages"
  task :publish => [:generate] do
    Tasks::Deploy.github_pages
  end

  desc "Sync generated site to S3"
  task :sync_with_s3 => [:generate] do
    Tasks::Deploy.s3
  end
end