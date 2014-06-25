Rails.application.routes.draw do

  resources :stickers

  root 'welcome#home'

  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end


end
