Rails.application.routes.draw do
  namespace :api do
    scope defaults: { format: :json } do
      post :results_data, to: 'results#create'
    end
  end
end
