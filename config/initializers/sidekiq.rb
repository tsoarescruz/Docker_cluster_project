require 'sidekiq/api'

redis_config = { url: ENV['REDIS_SIDEKIQ_URL'] }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end


# REDIS_CONN = proc do
#   host =     ENV['REDIS_URL']
#   port =     ENV['REDIS_PORT']
#
#   redis_ready = host.present? and port.present?
#
#   redis_url = if redis_ready
#                 "redis://#{host}:#{port}/"
#               else
#                 "redis://localhost:6379/"
#               end
#
#   r = Redis.new(url: redis_url)
#   Redis::Namespace.new("sidekiq", redis: r)
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = ConnectionPool.new(size: Sidekiq.options[:concurrency] + 5, timeout: 1, &REDIS_CONN)
# end
#
# Sidekiq.configure_server do |config|
#   config.redis = ConnectionPool.new(size: Sidekiq.options[:concurrency] + 10, timeout: 1, &REDIS_CONN)
#
#   config.server_middleware do |chain|
#     chain.remove Sidekiq::Middleware::Server::RetryJobs
#   end
# end


# require 'sidekiq/api'

# redis_config = { url: ENV['REDIS_URL'] }
#
# Sidekiq.configure_server do |config|
#   config.redis = redis_config
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = redis_config
# end


# if defined? Sidekiq
#   redis_url = ENV['REDIS_URL']
#
#   Sidekiq.configure_client do |config|
#     config.redis = { url: ENV['REDIS_URL']  }
#   end
#
#   Sidekiq.configure_server do |config|
#     config.redis = { url: ENV['REDIS_URL']}
#
#     # config.redis = {
#     #     :url => redis_url,
#     #     :namespace => 'phalanx_default',
#     #     :size => 28
#     # }
#   end
#
#   class Sidekiq::Extensions::DelayedMailer
#     sidekiq_options queue: :mailer, retry: 3
#   end
# end