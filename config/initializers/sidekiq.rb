# Sidekiq::Queue.all.each(&:clear)
# Sidekiq::RetrySet.new.clear
# Sidekiq::ScheduledSet.new.clear

if defined?(Sidekiq)
  Sidekiq.default_worker_options = { retry: 0 }
end
