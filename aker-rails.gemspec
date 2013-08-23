# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'aker/rails/version'

Gem::Specification.new do |s|
  s.name = 'aker-rails'
  s.version = Aker::Rails::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Easy Rails integration for the Aker security framework"
  s.license = 'MIT'

  s.require_path = 'lib'
  s.files = Dir.glob("{CHANGELOG.md,README.md,{lib,spec,rails}/**/*}")
  s.authors = ["David Yip", "Rhett Sutphin", "Peter Nyberg"]
  s.email = "r-sutphin@northwestern.edu"
  s.homepage = "https://github.com/NUBIC/aker-rails"

  s.add_runtime_dependency "rails", "~> 3.0", ">= 3.0.4"

  # This is deliberately open -- I expect that this rails plugin will
  # change much less frequently than the library.
  s.add_runtime_dependency 'aker', '~> 3.0'
end
