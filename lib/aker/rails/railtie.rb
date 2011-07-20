require 'aker/rails'

require 'rails/railtie'

module Aker::Rails
  class Railtie < ::Rails::Railtie
    initializer 'Aker::Rails initialization' do |app|
      Rails.logger.debug "Initializing Aker-Rails"

      Aker.configure do
        logger Rails.logger
      end

      Rack::Request.send(:include, Aker::Rack::RequestExt)
    end

    initializer 'Aker::Rails middleware installation' do |app|
      Rails.logger.debug "Installing Aker rack middleware"
      Rails.logger.debug "- UI mode:   #{Aker.configuration.ui_mode.inspect}"
      Rails.logger.debug "- API modes: #{Aker.configuration.api_modes.inspect}"
      Aker::Rack.use_in(app.middleware)
    end

    initializer 'Aker::Rails development support' do |app|
      app.config.to_prepare do
        ApplicationController.send(:include, Aker::Rails::Application)
      end
    end
  end
end
