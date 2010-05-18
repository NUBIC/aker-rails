require 'bcsec/rails'

module Bcsec::Rails
  ##
  # A mixin for the rails application controller.  Provides global
  # bcsec integration, but does not enforce any authentication or
  # authorization requirements.
  #
  # This module is automatically mixed into the application controller
  # when the plugin is initialized.
  module Application
    ##
    # Sets up helpers in the application controller.
    # @return [void]
    def self.included(controller_class)
      Bcsec::Rack.use_in(ActionController::Dispatcher.middleware)
      controller_class.class_eval do
        helper_method :current_user, :permit?, :permit
      end
    end

    ##
    # Exposes the logged-in user (if any) to the application.  This
    # method is also available to views (i.e., it is a helper).
    #
    # @return [Bcsec::User,nil]
    def current_user
      request.env["bcsec"].user
    end

    def permit?(*groups, &block)
      request.env["bcsec"].permit?(*groups, &block)
    end
    alias :permit :permit?
  end
end
