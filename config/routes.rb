Rails.application.routes.draw do
  namespace :api do
    post '/sign_up', to: 'authentication#sign_up'
    post '/sign_in', to: 'authentication#sign_in'
  end
end
