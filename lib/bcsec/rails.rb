require 'bcsec'

module Bcsec
  module Rails
    autoload :VERSION, 'bcsec/rails/version'

    autoload :Application,       'bcsec/rails/application'
    autoload :SecuredController, 'bcsec/rails/secured_controller'
  end

  # TODO: deprecate this somehow
  autoload :SecuredController, 'bcsec/rails/secured_controller'
end
