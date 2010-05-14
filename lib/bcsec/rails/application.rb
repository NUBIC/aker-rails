require 'bcsec/rails'

module Bcsec::Rails
  ##
  # A mixin for the rails application controller.  Provides global
  # bcsec integration, but does not enforce any authentication or
  # authorization requirements.
  module Application
    ##
    # Sets up helpers in the application controller
    def self.included(controller_class)
      Bcsec::Rack.use_in(ActionController::Dispatcher.middleware)
      controller_class.class_eval do
        helper_method :current_user
      end
    end

    def current_user
      request.env["bcsec"].user
    end
  end
end
