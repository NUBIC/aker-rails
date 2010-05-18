$LOAD_PATH << File.expand_path("lib", File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup

require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'cucumber/rake/task'
require 'yard'

require 'ci/reporter/rake/rspec'

require 'bcsec/rails'

gemspec = eval(File.read('bcsec-rails.gemspec'), binding, 'bcsec-rails.gemspec')

Rake::GemPackageTask.new(gemspec).define

GEM_FILE = "pkg/#{gemspec.file_name}"

desc "Show computed gemspec"
task 'gemspec' do
  puts gemspec.to_ruby
end

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

desc "Run all specs with rcov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  # rcov can't tell that /Library/Ruby is a system path
  t.rcov_opts = ['--exclude', "spec/*,/Library/Ruby/*"]
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

  desc "Run features that are flagged as failing on the current platform"
  Cucumber::Rake::Task.new(:wip_platform) do |t|
    t.fork = true
    t.profile = "wip_platform"
  end

  desc "Run all features"
  task :all => [:ok, :wip, :wip_platform]
end

desc "Build API documentation with yard"
docsrc = %w(lib/**/*.rb -) + Dir.glob("{CHANGELOG,README,MIGRATION}")
YARD::Rake::YardocTask.new do |t|
  t.options = %w(--no-private --markup markdown)
  t.files = docsrc
end

namespace :yard do
  desc "Rebuild API documentation after each change to the source"
  task :auto => :yard do
    require 'fssm'
    puts "Waiting for changes"
    FSSM.monitor('.', docsrc) do
      # have to run in a subshell because rake will only invoke a
      # given task once per execution
      yardoc = proc { |b, m|
        print "Detected change in #{m} -- regenerating docs ... "
        system("rake yard > /dev/null 2>&1")
        puts "done"
      }

      create &yardoc
      update &yardoc
      delete &yardoc
    end
  end

  desc "Purge all YARD artifacts"
  task :clean do
    rm_rf 'doc'
    rm_rf '.yardoc'
  end
end

task :default => :spec

desc "Reinstall the current development gem"
task :install => [:repackage, :uninstall] do
  puts "Installing new snapshot of #{gemspec.name}-#{gemspec.version}"
  puts `gem install #{GEM_FILE}`
end

desc "Uninstall the current development gem (if any)"
task :uninstall do
  puts "Removing existing #{gemspec.name}-#{gemspec.version}, if any"
  puts `gem uninstall #{gemspec.name} --version '=#{gemspec.version}'`
end

namespace :ci do
  task :all => [:spec, :cucumber]

  ENV["CI_REPORTS"] = "reports/spec-xml"
  task :spec => ["ci:setup:rspec", 'spec:rcov']

  Cucumber::Rake::Task.new(:cucumber, 'Run features using the ci profile') do |t|
    t.fork = true
    t.profile = 'ci'
  end
end
task :autobuild => :'ci:all'
