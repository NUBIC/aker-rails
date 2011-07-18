# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'aker/rails/version'

Gem::Specification.new do |s|
  s.name = 'aker-rails'
  s.version = Aker::Rails::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Bioinformatics core security infrastructure plugin for rails"

  s.require_path = 'lib'
  s.files = Dir.glob("{CHANGELOG,README,VERSION,{lib,spec,rails}/**/*}")
  s.authors = ["Rhett Sutphin", "Peter Nyberg"]
  s.email = "r-sutphin@northwestern.edu"
  s.homepage = "https://code.bioinformatics.northwestern.edu/redmine/projects/aker-ruby"

  s.add_runtime_dependency "rails", "~> 2.3.5" # for now; 2.1 will support Rails 3

  # This is deliberately open -- I expect that this rails plugin will
  # change much less frequently than the library.
  s.add_runtime_dependency 'aker', '~> 3.0'
end
