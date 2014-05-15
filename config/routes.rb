Rails.application.routes.draw do
  root 'reports#index'

  mount Nicocal::API => '/api'
end
