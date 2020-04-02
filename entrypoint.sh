rm -f tmp/pids/server.pid

rake db:create
rake db:migrate

bundle exec rails server --binding 0.0.0.0 --port 3000

