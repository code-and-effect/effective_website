web: bundle exec passenger start -p $PORT --max-pool-size 3
worker: bundle exec sidekiq -c 2 -q default -q mailers
release: bundle exec rake db:migrate
