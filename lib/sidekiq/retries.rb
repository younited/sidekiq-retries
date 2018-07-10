require "sidekiq/retries/version"
require 'sidekiq/retries/server/middleware'
require 'sidekiq/retries/errors'

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Retries::Server::Middleware
  end
end
