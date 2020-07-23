Rails.application.routes.draw do
  resources :merchant_accounts
  resources :dwolla_merchants
  resources :dwolla_securities
  resources :fund_transfers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
