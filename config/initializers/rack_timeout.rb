if Rails.env.production?
  Rack::Timeout.timeout = 26
end
