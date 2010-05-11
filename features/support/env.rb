require 'rubygems'
require 'bundler'
Bundler.setup

require 'spec'
require 'cucumber/formatter/unicode'
require 'capybara'
require 'capybara/dsl'

Capybara.default_driver = :culerity
Capybara.default_selector = :css

# Note: there is additional boot-time configuration after the world
# definition

module Bcsec::Rails
  module Cucumber
    class World
      include Spec::Matchers
      include Capybara

      APP_BASE = File.expand_path("../../../test-applications/serenity-23", __FILE__)
      APP_PORT = 3636

      def self.start_app
        system("BUNDLE_GEMFILE=\"#{APP_BASE}/Gemfile\" #{APP_BASE}/script/server -p #{APP_PORT} -d")
        fail "Server startup from #{APP_BASE} failed" unless $? == 0
        Capybara.app_host = "http://localhost:#{APP_PORT}"
        # shelling out is much less code than using Net::HTTP
        while `curl -s #{Capybara.app_host}`.empty?
          sleep 1
        end
      end

      def self.stop_app
        pid_file = "#{APP_BASE}/tmp/pids/server.pid"
      end
    end
  end
end

World do
  Bcsec::Rails::Cucumber::World.new
end

# The application uses a separate bundle, so it needs to run in a
# completely separate process.  However, it doesn't change from test
# to test, so it doesn't need to be started and stopped with each
# test.
Capybara.run_server = false
Bcsec::Rails::Cucumber::World.start_app
at_exit do
  Bcsec::Rails::Cucumber::World.stop_app
end
