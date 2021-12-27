Rails.application.routes.draw do
  devise_for :users do
    
  end
  resources :projects, except: :show do
    resources :categories, except: :show do
      resources :tasks, except: :show do
        get 'status', to: "toggles#status", as: "status"
      end 
    end
  end  
  # root "projects#index"
  root "pages#home"
  get 'about', to: "pages#about"
  get 'home', to: "pages#home"
  get "all", to: "task_only#all"
  get "complete", to: "task_only#complete"
  get "uncomplete", to: "task_only#uncomplete"
end
