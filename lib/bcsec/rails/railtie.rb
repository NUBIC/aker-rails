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
  end
end
