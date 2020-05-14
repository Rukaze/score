require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Score
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.hosts << 'e43df44d87af408b8b105b12a224da15.vfs.cloud9.ap-northeast-1.amazonaws.com'
    config.hosts << "18.176.153.16"
    config.hosts << "bascore.herokuapp.com"
    config.hosts << "basketballscore.ddo.jp"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
