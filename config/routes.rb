Rails.application.routes.draw do
  root "projects#index"
  resources :projects, except: :show do
    resources :categories, except: :show do
      resources :tasks, except: :show do
        get 'status', to: "toggles#status", as: "status"
      end 
    end
  end  
end
