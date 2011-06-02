Serenity30::Application.routes.draw do
  match '/' => 'public#view', :format => 'text'
  match 'portal' => 'public#portal', :format => 'text'
  match 'protected' => 'protected#authentication_only', :format => 'text'
  match 'owners' => 'permit#owners_only', :format => 'text'

  match '/login' => 'accounts#login', :via => [:get, :post]
  match '/logout' => 'accounts#logout', :via => :get
end
