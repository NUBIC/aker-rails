require 'bcsec/rails'

module Bcsec::Rails
  module SecuredController
    def self.included(controller_class)
      controller_class.before_filter :bcsec_authorize
      controller_class.extend ClassMethods
    end

    def bcsec_authorize
      request.env['bcsec'].authentication_required!
    end

    module ClassMethods
      def permit(*groups)
        options =
          if Hash === groups.last
            groups.pop
          else
            {}
          end

        before_filter(options) do |controller|
          controller.request.env['bcsec'].permit!(*groups)
        end
      end
    end
  end
end

module Bcsec
  class << self
    alias :prerails_const_missing :const_missing

    def const_missing(name)
      case name
      when :SecuredController
        Bcsec::Deprecation.
          notify("Use Bcsec::Rails::SecuredController instead of Bcsec::SecuredController.", "2.2")
        Bcsec::Rails::SecuredController
      else
        prerails_const_missing(name)
      end
    end
  end
end
