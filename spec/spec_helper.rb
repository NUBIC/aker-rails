require 'rubygems'
require 'bundler'
Bundler.setup

require "spec"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'bcsec/rails'

Spec::Runner.configure do |config|

end
