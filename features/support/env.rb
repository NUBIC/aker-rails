require 'rubygems'
require 'bundler'
Bundler.setup

require 'spec'
require 'fileutils'
require 'mechanize'
require 'cucumber/formatter/unicode'
require 'uri'

require File.expand_path('../mechanize_test', __FILE__)

# Note: there is additional boot-time configuration after the world
# definition

module Aker::Rails
  module Cucumber
    class World
      include Aker::Rails::Cucumber::MechanizeTest
      include FileUtils
      include Spec::Matchers

      APP_BASE = File.expand_path("../../../test-applications/serenity-30", __FILE__)
      APP_PORT = 6363

      def self.base_uri
        "http://localhost:#{APP_PORT}/"
      end

      def self.start
        start_app
      end

      def self.stop
        stop_app
      end

      def self.clean_rubyopt
        (ENV['RUBYOPT'] || '').split(' ').reject { |o| o =~ /bundler/ }.join(' ')
      end

      def self.in_ci?
        ENV['BUILD_ID']
      end

      def self.start_app
        FileUtils.cd APP_BASE do
          bundle_env="BUNDLE_GEMFILE=\"#{APP_BASE}/Gemfile\" RUBYOPT=\"#{clean_rubyopt}\""
          should_install = in_ci? ||
            begin
              system("#{bundle_env} bundle check > /dev/null")
              $? != 0
            end
          if should_install
            system("#{bundle_env} bundle update")
            fail "Test application bundle install failed" unless $? == 0
          end
          system("#{bundle_env} script/rails server -p #{APP_PORT} -d")
          fail "Server startup from #{APP_BASE} failed" unless $? == 0
        end

        # shelling out is much less code than using Net::HTTP
        time = 0
        not_up = lambda { `curl -s #{base_uri}`.empty? }
        while not_up.call && time < 20
          time += 1
          sleep 1
        end
        fail "App startup timeout expired" if not_up.call
      end

      def self.stop_app
        begin
        pid_file = "#{APP_BASE}/tmp/pids/server.pid"
        if File.exist?(pid_file)
          Process.kill "KILL", File.read(pid_file).strip.to_i
        else
          $stderr.puts "Could not determine PID for test app"
        end
        rescue => e
          $stderr.puts "Killing the test app failed: #{e}"
        end
      end

      def app_url(path)
        URI.join(self.class.base_uri, path).to_s
      end

      def tmpdir
        @tmpdir ||= "/tmp/aker-rails-rails3-integrated-tests"
        unless File.exist?(@tmpdir)
          mkdir_p @tmpdir
          puts "Using tmpdir #{@tmpdir}"
        end
        @tmpdir
      end
    end
  end
end

World do
  Aker::Rails::Cucumber::World.new
end

# The application uses a separate bundle, so it needs to run in a
# completely separate process.  However, it doesn't change from test
# to test, so it doesn't need to be started and stopped with each
# test.
at_exit do
  Aker::Rails::Cucumber::World.stop
end
Aker::Rails::Cucumber::World.start
