require 'aker/rails'

module Aker::Rails
  ##
  # This mixin tags a controller as always requiring authentication.
  #
  # It also adds a
  # {Aker::Rails::SecuredController::ClassMethods#permit method}
  # which allows you to mark a controller as only accessible to a
  # particular group or groups.  For example:
  #
  #     class SecretController
  #       include Aker::Rails::SecuredController
  #       permit :confidential
  #     end
  module SecuredController
    ##
    # @private implements the behavior described by the module
    #   description
    # @return [void]
    def self.included(controller_class)
      controller_class.before_filter :aker_authorize
      controller_class.extend ClassMethods
    end

    ##
    # The filter which actually forces any user accessing a controller
    # which mixes this in to be authenticated.
    #
    # It delegates to {Aker::Rack::Facade#authentication_required!};
    # see that method's documentation for more information.
    #
    # @return [void]
    def aker_authorize
      request.env['aker'].authentication_required!
    end

    ##
    # Extensions for the rails controller DSL for
    # authentication-required controllers.
    #
    # @see SecuredController
    module ClassMethods
      ##
      # Tags a controller as requiring that a user both be
      # authenticated and belong to one of a set of groups.
      #
      # It delegates to {Aker::Rack::Facade#permit!}; see that
      # methods's documentation for more information.
      #
      # @return [void]
      def permit(*groups)
        options =
          if Hash === groups.last
            groups.pop
          else
            {}
          end

        before_filter(options) do |controller|
          controller.request.env['aker'].permit!(*groups)
        end
      end
    end
  end
end

module Aker
  class << self
    alias :prerails_const_missing :const_missing

    ##
    # @private -- provides deprecated features only
    def const_missing(name)
      case name
      when :SecuredController
        Aker::Deprecation.
          notify("Use Aker::Rails::SecuredController instead of Aker::SecuredController.", "2.2")
        Aker::Rails::SecuredController
      else
        prerails_const_missing(name)
      end
    end
  end
end
