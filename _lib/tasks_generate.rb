require 'jekyll'

module Tasks
  def self.generate
    configuration = Jekyll.configuration({})
    site = Jekyll::Site.new(configuration)
    site.process
    true
  end
end