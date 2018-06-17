Rails.application.routes.draw do
  resources :timetables
  resources :staffcourses
  devise_scope :student do
     get "/" => "students/sessions#new" 
  end
  get 'events/index'
  resources :events
  resources :messages
  get 'message' , to: 'messages#index'

  get 'notifications', to:'notifications#index' 
  get 'current_user' => "home#current_user"

  resources :cvs do
    get 'company', on: :collection
  end

  resources :courses_tracks
  resources :lists
  resources :tags, only: [:show]

  resources :coursestudenttracks do
    member do
      put "/update", to: "coursestudenttracks#update"
    end 
  end
  resources :coursestafftracks do
    member do
      post 'beforenew' => 'coursestafftracks#beforenewpost'
    end
  end
  resources :assignmentstaffstudents do
    member do
      post 'submitcodereview' => 'assignmentstaffstudents#submitcodereview'
    end
  end
  resources :staffs
  resources :events
  resources :courses do
    member do
      put "upload", to: "assignmentstaffstudents#new"
      get "grades", to:"coursestudenttracks#show"
      get "allcourses", to: "courses#allcourses"
    end 
  end
  resources :assignments do
    member do
      post 'beforenew' => 'assignments#beforenewpost'
    end
  end
  get "/totrack", to: "assignments#beforenew"
  get "/tochoosetrack", to: "coursestafftracks#beforenew"
  resources :tracks
  resources :groups
  resources :posts, path: 'home' do
  member do
    put "like", to: "posts#upvote"
    put "dislike", to: "posts#downvote"
  end
end

match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

  mount Commontator::Engine => '/commontator'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :students, controllers: { registrations: 'students/registrations', sessions: 'students/sessions' }
  devise_scope :students do
    get 'students/sign_in' => 'students/sessions#new'
    get 'students/sign_up' => 'errors/error404'
  end
class ActiveAdmin::Devise::SessionsController
   	def after_sign_in_path_for(resource)
    # if current_admin_user.Instructor
    if current_admin_user.role == "Instructor"
        '/home'
    else 
        '/admin/dashboard'
  	end
    end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
