require 'aker/rails'

Rails.logger.debug "Initializing aker-rails"
# We do this up here to allow the application to override if desired
Aker.configure {
  logger Rails.logger
}
config.after_initialize do
  Aker::Rails::Application.one_time_setup

  if config.cache_classes
    ApplicationController.send(:include, Aker::Rails::Application)
  else
    config.to_prepare do
      ApplicationController.send(:include, Aker::Rails::Application)
    end
  end
end
