require 'bcsec/rails'

require 'rails/railtie'

module Bcsec::Rails
  class Railtie < ::Rails::Railtie
    initializer 'Bcsec::Rails initialization' do |app|
      Rails.logger.debug "Initializing bcsec-rails"

      Bcsec.configure do
        logger Rails.logger
      end

      Bcsec::Rack.use_in(app.middleware)

      Rack::Request.send(:include, Bcsec::Rack::RequestExt)
    end

    initializer 'Bcsec::Rails development support' do |app|
      app.config.to_prepare do
        ApplicationController.send(:include, Bcsec::Rails::Application)
      end
    end

    initializer 'Custom login/logout forms' do |app|
      app.config.to_prepare do
        app.routes_reloader.execute_if_updated

        custom_login  = app.routes.routes.any? { |r| r.path =~ %r{^/login} }
        custom_logout = app.routes.routes.any? { |r| r.path =~ %r{^/logout} }

        Bcsec.configure do
          form_parameters :use_custom_login_page => custom_login, :use_custom_logout_page => custom_logout
        end
      end
    end
  end
end
