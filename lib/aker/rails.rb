require 'aker'

module Aker
  ##
  # Rails integration for aker.  In general, it is a thin wrapper
  # around aker's rack integration.
  #
  # Everything in this module is in the `aker-rails` gem plugin.
  module Rails
    autoload :VERSION, 'aker/rails/version'

    autoload :Application,       'aker/rails/application'
    autoload :Railtie,           'aker/rails/railtie'
    autoload :SecuredController, 'aker/rails/secured_controller'
    autoload :Test,              'aker/rails/test'
  end
end
