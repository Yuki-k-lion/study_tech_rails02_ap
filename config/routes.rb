TechReviewSite::Application.routes.draw do
  # get   'products/:product_id/reviews/new'  =>  'reviews#new'
  # post  'products/:product_id/reviews'      =>  'reviews#create'
  
  resources reviews, only: [:new, :create]
  
  resources :products, only: :show do
    collection do
      get 'search'
    end
  end
  root 'products#index'

end
