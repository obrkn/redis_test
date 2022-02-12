Rails.application.routes.draw do
  root to: "home#index"

  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"
end
