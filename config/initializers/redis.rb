if Rails.env.production?
  $redis = Redis.new(url: ENV.fetch('REDIS_URL'))
end
