gem "twitter-bootstrap-rails"

bundle exec rails g bootstrap:install
bundle exec rails g bootstrap:install
bundle exec rails g bootstrap:layout application fuild

bundle exec rails g scaffold User nickname:string email:string firstname:string lastname:string bio:text
bundle exec rake db:migrate
bundle exec rails g bootstrap:themed Users

bundle exec rails g model relationships follower_id:integer followed_id:integer
