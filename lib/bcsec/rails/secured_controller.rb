require 'bcsec/rails'

module Bcsec::Rails
  module SecuredController
    def self.included(controller_class)
      controller_class.before_filter :bcsec_authorize
    end

    def bcsec_authorize
      request.env['bcsec'].authentication_required!
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
