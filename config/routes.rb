Rails.application.routes.draw do
  #home.html.erbの内容がトップページに表示されるようになる
  root to: 'static_pages#home'
end
