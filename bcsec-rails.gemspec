# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bcsec/rails/version'

require 'rubygems'
begin
  require 'bundler'
rescue LoadError
  fail "Evaluating this gemspec requires bundler.  Install it and then try again."
end

Gem::Specification.new do |s|
  s.name = 'bcsec-rails'
  s.version = Bcsec::Rails::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Bioinformatics core security infrastructure plugin for rails"

  s.add_bundler_dependencies

  s.require_path = 'lib'
  s.files = Dir.glob("{CHANGELOG,README,VERSION,{lib,spec}/**/*}")
  s.authors = ["Rhett Sutphin", "Peter Nyberg"]
  s.email = "r-sutphin@northwestern.edu"
  s.homepage = "https://code.bioinformatics.northwestern.edu/redmine/projects/bcsec-ruby"
end
