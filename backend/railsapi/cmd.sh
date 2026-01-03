rm -f tmp/pids/server.pid

bundle exec rake db:prepare

exec bundle exec rails s -b 0.0.0.0 -p 3000
