Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [] do
    member do
      post :add_to_basket
    end

    collection do
      delete :clear_basket
    end
  end
end
