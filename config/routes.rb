Rails.application.routes.draw do
  devise_for :users

  resources :painters do
    resources :deductions
  end
  resources :sites

  post 'dashbaord/assign_site', as: :assign_site
  post 'dashbaord/add_notes', 	as: :add_notes

  get  'wages/weekly', 				to: 'wages#weekly',  		 as: :weekly_wages
  get  'wages/monthly', 			to: 'wages#monthly', 		 as: :monthly_wages
  get  'wages/monthly/:painter_id', to: 'wages#painter_monthly', as: :painter_monthly_wage

  get  'deductions', to: 'deductions#all', as: :deductions
  root 'dashbaord#index'
end
