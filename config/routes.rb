Rails.application.routes.draw do
  resources :projects do
    resources :categories do
      resources :tasks
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
