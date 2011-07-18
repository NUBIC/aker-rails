require 'aker/rails'

module Aker::Rails
  ##
  # A mixin for the rails application controller.  Provides global
  # aker integration, but does not enforce any authentication or
  # authorization requirements.  (See
  # {Aker::Rails::SecuredController} for one way to enforce
  # authentication and authorization.)
  #
  # This module is automatically mixed into the application controller
  # when the plugin is initialized.
  module Application
    ##
    # Sets up the aker global infrastructure and helpers in the
    # application controller.
    #
    # @return [void]
    def self.included(controller_class)
      controller_class.class_eval do
        helper_method :current_user, :permit?, :permit
      end
    end

    ##
    # Sets up the aker global infrastructure that is not affected by
    # Rails' development-mode class reloading.
    #
    # @return [void]
    def self.one_time_setup
      Aker::Rack.use_in(ActionController::Dispatcher.middleware)
      Rack::Request.send(:include, Aker::Rack::RequestExt)
    end

    ##
    # Exposes the logged-in user (if any) to the application.
    #
    # This method is also available to views (i.e., it is a helper).
    #
    # @return [Aker::User,nil]
    def current_user
      request.env['aker.check'].user
    end

    ##
    # Aids group-level authorization.  It is safe to call this method
    # without checking that there is a logged in user first.
    #
    # This method delegates directly to {Aker::Rack::Facade#permit?};
    # see the documentation for that method for more information.
    #
    # This method is also available to views (i.e., it is a helper).
    #
    # @return [Boolean,Object,nil]
    def permit?(*groups, &block)
      request.env['aker.check'].permit?(*groups, &block)
    end
    alias :permit :permit?
  end
end
