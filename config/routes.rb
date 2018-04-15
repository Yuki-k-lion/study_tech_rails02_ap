TechReviewSite::Application.routes.draw do
  devise_for :users
  # get   'products/:product_id/reviews/new'  =>  'reviews#new'
  # post  'products/:product_id/reviews'      =>  'reviews#create'
  
  resources :products, only: :show do
    
    resources :reviews, only: [:new, :create]
  
    collection do
      get 'search'
    end
  end
  
  root 'products#index'

end
