require "spec"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'bcsec/rails'

require File.expand_path('../deprecation_helper', __FILE__)

Spec::Runner.configure do |config|
  Bcsec::Rails::Spec::DeprecationMode.use_in(config)
end
