# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    get '/restapis/index', to: 'restapis#index'
    post '/restapis/result', to: 'restapis#result'
end