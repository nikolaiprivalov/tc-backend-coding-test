Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope as: :restaurants, module: :restaurants do
      get 'availability/:restaurant_id', to: 'availability#query', as: :availability_query
      post 'reservations/:restaurant_id', to: 'reservations#create', as: :reservations
    end
  end
end
