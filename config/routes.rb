Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => redirect('/movies')

  resources :movies
  get 'moviesByDirector/:id', to: 'movies#movies_by_director', as: :movies_by_director
end
