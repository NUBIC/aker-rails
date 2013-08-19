Serenity40::Application.routes.draw do
  get '/' => 'public#view', :format => 'text'
  get 'portal' => 'public#portal', :format => 'text'
  match 'protected' => 'protected#authentication_only', :format => 'text', :via => [:get, :post]
  get 'owners' => 'permit#owners_only', :format => 'text'

  match '/login'  => 'accounts#login',  :via => [:get, :post]
  match '/logout' => 'accounts#logout', :via => :get
end
