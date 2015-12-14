Rails.application.routes.draw do
  devise_for :users

  resources :painters
  resources :sites

  post 'dashbaord/assign_site', as: :assign_site
  post 'dashbaord/add_notes', 	as: :add_notes

  get  'wages/weekly', 				to: 'wages#weekly',  		 as: :weekly_wages
  get  'wages/monthly', 			to: 'wages#monthly', 		 as: :monthly_wages
  get  'wages/monthly/:painter_id', to: 'wages#painter_monthly', as: :painter_monthly_wage

  root 'dashbaord#index'
end
