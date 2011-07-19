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
  end
end
