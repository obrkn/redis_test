## sidekiq起動
```yml:docker-compose.yml
  redis:
    image: redis
    ports:
     - 6379:6379
    volumes:
     - ./tmp/redis:/data
```
```:Gemfile
gem 'sidekiq'
```
```ruby:config/application.rb
module YourAppName
  class Application < Rails::Application
    # 中略
    config.active_job.queue_adapter = :sidekiq
  end
end
```
```ruby:config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379' }
end
```
```sh:sh
$ bundle exec sidekiq
```

## cron起動
```:Dockerfile
RUN apt-get update -qq && apt-get install -y cron
```
```:Gemfile
gem 'whenever', require: false
```
```sh:sh
$ bundle install
$ wheneverize .
```
```ruby:
require File.expand_path(File.dirname(__FILE__) + "/environment")

# 実行環境を指定する
set :environment, Rails.env.to_sym
# 実行logの出力先
set :output, "#{Rails.root.to_s}/log/cron.log"

every 2.minutes do
  command "echo 'hogehoge'"
end
```
```sh:sh
$ /etc/init.d/cron start # cron起動
$ whenever --update-crontab # whenever反映
$ whenever --clear-crontab # whenever無効化
$ whenever # 確認
$ /etc/init.d/cron stop # cron停止
$ ps -aux # cron起動確認
```
## Redis確認
```sh:zsh
$ docker-compose exec redis sh
# redis-cli
> keys *
> type mykey
> ZRANGE mykey 0 -1
```
