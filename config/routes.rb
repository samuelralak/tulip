Rails.application.routes.draw do
  resources :clients
  resources :materials
  devise_for :users, skip: [:registrations] 
    devise_scope :user do
      get "/users/edit" => "devise/registrations#edit",   as: :edit_user_registration
      put "/users" => "devise/registrations#update", as: :user_registration                                             
    end

  resources :painters do
    resources :deductions, except: [:show]

    member do
      post :deactivate
    end
  end
  
  resources :sites
  resources :bonus
  resources :skills
  resources :paints
  resources :invoices, except: [:destroy]
  resources :payments, except: [:show]
  resources :holidays, except: [:show]
  resources :petty_cashes, except: [:show] do
    resources :petty_cash_items, only: [:index, :create, :new]
  end
  resources :user_accounts


  post 'dashbaord/assign_site', as: :assign_site
  post 'dashbaord/add_notes', 	as: :add_notes

  get  'wages/weekly', 				to: 'wages#weekly',  		 as: :weekly_wages

  get  'wages/monthly',       to: 'wages#monthly',     as: :monthly_wages
  get  'wages/monthly/:painter_id', to: 'wages#painter_monthly', as: :painter_monthly_wage

  get  'wages/permanent', 			to: 'wages#permanent', 		 as: :permanent_wages
  get  'wages/permanent/:painter_id', to: 'wages#painter_permanent', as: :painter_permanent_wage

  get  'transactions/:site_id', to: 'sites#site_transactions', as: :transactions

  get  'deductions', to: 'deductions#all', as: :deductions
  root 'dashbaord#index'
end
