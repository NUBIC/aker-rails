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
  SecuredController = Rails::SecuredController
end
