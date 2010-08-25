require 'bcsec'

module Bcsec
  ##
  # Rails integration for bcsec.  In general, it is a thin wrapper
  # around bcsec's rack integration.
  #
  # Everything in this module is in the `bcsec-rails` gem plugin.
  module Rails
    autoload :VERSION, 'bcsec/rails/version'

    autoload :Application,       'bcsec/rails/application'
    autoload :SecuredController, 'bcsec/rails/secured_controller'
    autoload :Test,              'bcsec/rails/test'
  end

  # TODO: deprecate this somehow
  autoload :SecuredController, 'bcsec/rails/secured_controller'
end
