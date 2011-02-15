require 'bcsec/rails'

Rails.logger.debug "Initializing bcsec-rails"
# We do this up here to allow the application to override if desired
Bcsec.configure {
  logger Rails.logger
}
config.after_initialize do
  Bcsec::Rails::Application.one_time_setup

  if config.cache_classes
    ApplicationController.send(:include, Bcsec::Rails::Application)
  else
    config.to_prepare do
      ApplicationController.send(:include, Bcsec::Rails::Application)
    end
  end
end
