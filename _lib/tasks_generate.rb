require 'jekyll'

module Tasks
  DEFAULT_CONFIGURATION = {
      "source"      => ".",
      "destination" => "_site"
  }

  def self.generate
    configuration = Jekyll.configuration(DEFAULT_CONFIGURATION)
    site = Jekyll::Site.new(configuration)
    site.process
    true
  end
end