$LOAD_PATH << File.expand_path("lib", File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup

require 'rubygems/package_task'
require 'spec/rake/spectask'
require 'cucumber/rake/task'
require 'yard'
require 'net/ssh'
require 'net/scp'

require 'ci/reporter/rake/rspec'

require 'bcsec/rails'

gemspec = eval(File.read('bcsec-rails.gemspec'), binding, 'bcsec-rails.gemspec')

Gem::PackageTask.new(gemspec).define

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
# README is included automatically
docsrc = %w(lib/**/*.rb -) + Dir.glob("{CHANGELOG,MIGRATION}-rails")
YARD::Rake::YardocTask.new do |t|
  t.options = %w(--no-private --markup markdown --hide-void-return)
  t.options += ["--title", "bcsec-rails #{Bcsec::Rails::VERSION}"]
  t.files = docsrc
end

namespace :yard do
  desc "Rebuild API documentation after each change to the source"
  task :auto => :yard do
    require 'fssm'
    puts "Waiting for changes"
    FSSM.monitor('.', docsrc + %w(Rakefile)) do
      # have to run in a subshell because rake will only invoke a
      # given task once per execution
      yardoc = proc { |b, m|
        print "Detected change in #{m} -- regenerating docs ... "
        out = `rake yard`
        if out =~ /warn|error/
          puts out
        end
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

desc "Deploy to the internal gem server"
task :deploy => :"deploy:gem"

def trace?
  Rake.application.options.trace
end

def one_ssh_cmd(ssh, cmd)
  $stderr.puts "\n-> #{cmd}" if trace?
  ssh.exec(cmd)
  ssh.loop
end

namespace :deploy do
  task :check do
    if Bcsec::Rails::VERSION.split('.').any? { |v| v =~ /\D/i }
      puts "#{Bcsec::Rails::VERSION} is a prerelease version.  " <<
        "Are you sure you want to deploy?\n" <<
        "Press ^C to abort or enter to continue deploying."
      STDIN.readline
    end
  end

  task :gem => [:check, :repackage] do
    server = "ligand"
    user = ENV["BC_USER"] or raise "Please set BC_USER=your_netid in the environment"
    target = File.basename(GEM_FILE)
    Net::SSH.start(server, user) do |ssh|
      puts "-> Uploading #{GEM_FILE}"
      channel = ssh.scp.upload(GEM_FILE, "/home/#{user}") do |ch, name, sent, total|
        puts sent == total ? "  complete" : "  #{sent}/#{total}"
      end
      channel.wait

      one_ssh_cmd(ssh, "deploy-gem #{target}")
    end
  end

  desc "Tag the final version of a release"
  task :tag => [:check] do
    tagname = Bcsec::Rails::VERSION
    system("git tag -a #{tagname} -m 'Bcsec-Rails #{Bcsec::Rails::VERSION}'")
    fail "Tagging failed" unless $? == 0
    system("git push origin : #{tagname}")
  end
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
