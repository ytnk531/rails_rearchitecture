Rails.application.routes.draw do
  resources 'unit_of_works'
  resources 'pessimistic_offline_locks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
