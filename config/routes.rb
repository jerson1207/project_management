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
  root "projects#index"
  get 'about', to: "pages#about"
  get 'all_tasks', to: "pages#all_tasks"
  get 'completed_tasks', to: "pages#completed_tasks"
  get 'uncomplete_tasks', to: "pages#uncomplete_tasks"
end
