require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
  Sidekiq::Scheduler.dynamic = true
  # Remove the code that loads the schedule configuration
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end
