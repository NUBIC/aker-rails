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
    end
  end
end
