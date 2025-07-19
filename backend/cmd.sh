rm -f /railsapi/tmp/pids/server.pid

rake db:create
rake db:migrate

bundle exec rspec

rails s -b 0.0.0.0 -p 3000
