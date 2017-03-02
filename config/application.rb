require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Phalanxs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Loads active_job to sidekiq
    # Affects all environments
    config.active_job.queue_adapter     = :sidekiq
    config.active_job.queue_name_prefix = "phalanx"
  end
end
