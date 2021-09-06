Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [] do
    member do
      post :add_to_cart
    end

    collection do
      delete :clear_cart
    end
  end
end
