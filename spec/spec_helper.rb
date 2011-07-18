require 'rubygems'
require 'bundler'
Bundler.setup

require "spec"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'aker/rails'

require File.expand_path('../deprecation_helper', __FILE__)

Spec::Runner.configure do |config|
  Aker::Rails::Spec::DeprecationMode.use_in(config)
end
