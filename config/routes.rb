Rails.application.routes.draw do

  get 'pages/how_it_works'

  get 'pages/printing_process'

  get 'pages/help'

  root 'welcome#home'


end
