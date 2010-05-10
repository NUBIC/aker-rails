# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bcsec/rails/version'

# Evaluates a gemfile and appends the deps to a gemspec.
# Later versions of bundler may have a method for this.
class GemfileGemspecDeps
  def initialize(gemspec)
    @gem = gemspec
    instance_eval File.read('Gemfile')
  end

  def method_missing(msg, *args)
    # skip unimplemented bits
  end

  def gem(name, version=nil, opts={})
    version = nil unless String === version # screen out gem 'name', opts
    if @group && @group.include?(:development)
      @gem.add_development_dependency(name, version)
    else
      @gem.add_runtime_dependency(name, version)
    end
  end

  def group(*kinds)
    @group = kinds
    yield
    @group = nil
  end
end


Gem::Specification.new do |s|
  s.name = 'bcsec-rails'
  s.version = Bcsec::Rails::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Bioinformatics core security infrastructure plugin for rails"

  GemfileGemspecDeps.new(s)

  s.require_path = 'lib'
  s.files = Dir.glob("{CHANGELOG,README,VERSION,{lib,spec}/**/*}")
  s.authors = ["Rhett Sutphin", "Peter Nyberg"]
  s.email = "r-sutphin@northwestern.edu"
  s.homepage = "https://code.bioinformatics.northwestern.edu/redmine/projects/bcsec-ruby"
end
