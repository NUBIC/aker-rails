$LOAD_PATH << File.expand_path("lib", File.dirname(__FILE__))

require 'rubygems'
require 'bundler/gem_tasks'

require 'spec/rake/spectask'
require 'cucumber/rake/task'
require 'yard'

require 'ci/reporter/rake/rspec'

require 'aker/rails'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

namespace :cucumber do
  desc "Run features that should pass"
  Cucumber::Rake::Task.new(:ok) do |t|
    t.fork = true
    t.profile = "default"
  end

  desc "Run features that are being worked on"
  Cucumber::Rake::Task.new(:wip) do |t|
    t.fork = true
    t.profile = "wip"
  end

  desc "Run all features"
  task :all => [:ok, :wip]
end

desc "Shortcut for yard:auto"
task :yard => 'yard:auto'

namespace :yard do
  desc "Run a server which will rebuild documentation as the source changes"
  task :auto do
    system("bundle exec yard server --reload")
  end

  desc "Build API documentation with yard"
  YARD::Rake::YardocTask.new("once") do |t|
    t.options = ["--title", "Aker-Rails #{Aker::VERSION}"]
  end

  desc "Purge all YARD artifacts"
  task :clean do
    rm_rf 'doc'
    rm_rf '.yardoc'
  end
end

task :default => :spec

task 'release' => ['deploy:check']

namespace :deploy do
  task :check do
    if Aker::Rails::VERSION.split('.').any? { |v| v =~ /\D/i }
      puts "#{Aker::Rails::VERSION} is a prerelease version.  " <<
        "Are you sure you want to deploy?\n" <<
        "Press ^C to abort or enter to continue deploying."
      STDIN.readline
    end
  end
end

namespace :ci do
  task :all => [:spec, :cucumber]

  ENV["CI_REPORTS"] = "reports/spec-xml"
  task :spec => ["ci:setup:rspec", 'rake:spec']

  Cucumber::Rake::Task.new(:cucumber, 'Run features using the ci profile') do |t|
    t.fork = true
    t.profile = 'ci'
  end
end
task :autobuild => :'ci:all'
