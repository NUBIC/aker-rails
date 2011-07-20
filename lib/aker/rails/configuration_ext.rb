require 'aker/rails'
require 'rails/application/configuration'

module Aker::Rails
  ##
  # Provides sugar for configuring Aker via a Rails application's
  # configuration.
  #
  # The methods in this module operate on Aker's global configuration,
  # so changes made here will be visible on `Aker.configuration` and
  # vice versa.
  #
  # While everything here could be done with direct calls to methods
  # on `Aker`, this integration emphasizes that Aker configuration
  # **must be done during the configuration phase** of Rails boot
  # (i.e., in `config/application.rb` and
  # `config/environments/{env}.rb`). If Aker configuration is done in
  # the initialization phase or later, some features will not work
  # correctly.
  module ConfigurationExt
    ##
    # Access or update the Aker configuration in the context of this
    # Rails application.
    #
    # **N.b.:** While this method allows you to update the
    # configuration at any time, some configuration options will only
    # take full effect if they are set during the application's
    # initial boot.
    #
    # @example Reading the configuration
    #   unless Rails.configuration.aker.api_modes.empty?
    #     # do something that should only happen if API access is enabled
    #   end
    #
    # @example Updating the configuration
    #   # in config/environments/{environment}.rb
    #   MyApp::Application.configure do
    #     # ...
    #     config.aker do
    #       authority MyEnvSpecificAuthority
    #     end
    #     # ...
    #   end
    #
    # @param [Proc] block a block of Aker's configuration DSL. If
    #   given, it will be applied to the global Aker configuration.
    # @return [Aker::Configuration] the global Aker configuration.
    def aker(&block)
      if block
        Aker.configure(&block)
      end
      Aker.configuration
    end

    ##
    # Completely replace the Aker configuration. This should only
    # rarely (if ever) be necessary.
    #
    # @param [Aker::Configuration] aker_configuration the replacement configuration.
    # @return [void]
    def aker=(aker_configuration)
      Aker.configuration = aker_configuration
    end
  end
end

Rails::Application::Configuration.send(:include, Aker::Rails::ConfigurationExt)
