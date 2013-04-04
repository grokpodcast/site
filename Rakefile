require_relative '_lib/tasks/generate'
require_relative '_lib/tasks/deploy/github_pages'
require_relative '_lib/tasks/deploy/s3'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => ['generate']

desc "Generate blog files"
task :generate do
  Tasks.generate
end

namespace :deploy do
  desc "Generate and publish blog to gh-pages"
  task :github_pages => [:generate] do
    Tasks::Deploy::GithubPages.deploy
  end

  desc "Sync generated site to S3"
  task :s3 => [:generate] do
    Tasks::Deploy::S3.deploy
  end
end