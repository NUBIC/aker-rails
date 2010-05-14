require 'bcsec/rails'

Rails.logger.debug "Initializing bcsec-rails"
# We do this up here to allow the application to override if desired
Bcsec.configure {
  logger Rails.logger
}
config.after_initialize do
  ApplicationController.send(:include, Bcsec::Rails::Application)
end
