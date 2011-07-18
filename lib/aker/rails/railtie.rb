require 'aker/rails'

require 'rails/railtie'

module Aker::Rails
  class Railtie < ::Rails::Railtie
    initializer 'Aker::Rails initialization' do |app|
      Rails.logger.debug "Initializing aker-rails"

      Aker.configure do
        logger Rails.logger
      end

      Aker::Rack.use_in(app.middleware)

      Rack::Request.send(:include, Aker::Rack::RequestExt)
    end

    initializer 'Aker::Rails development support' do |app|
      app.config.to_prepare do
        ApplicationController.send(:include, Aker::Rails::Application)
      end
    end

    initializer 'Custom login/logout forms' do |app|
      app.config.to_prepare do
        app.routes_reloader.execute_if_updated

        custom_login  = app.routes.routes.any? { |r| r.path =~ %r{^/login} }
        custom_logout = app.routes.routes.any? { |r| r.path =~ %r{^/logout} }

        Aker.configure do
          rack_parameters :use_custom_login_page => custom_login, :use_custom_logout_page => custom_logout
        end
      end
    end
  end
end
