require 'rubygems'
require 'bundler'
Bundler.setup

require 'spec'
require 'cucumber/formatter/unicode'
require 'culerity'

require 'uri'

# Note: there is additional boot-time configuration after the world
# definition

module Bcsec::Rails
  module Cucumber
    class World
      include Spec::Matchers

      APP_BASE = File.expand_path("../../../test-applications/serenity-23", __FILE__)
      APP_PORT = 3636

      def self.culerity_server
        @culerity_server ||= Culerity.run_server
      end

      ##
      # Provides the culerity/celerity browser proxy
      def self.browser
        @browser ||=
          begin
            browser = Culerity::RemoteBrowserProxy.new(culerity_server,
                                                       :browser => :firefox3,
                                                       :javascript_exceptions => true,
                                                       :resynchronize => true,
                                                       :status_code_exceptions => false)
            browser.log_level = :warning
            browser.webclient.addRequestHeader("Accept", "text/html")
            browser
          end
      end

      def browser
        self.class.browser
      end

      def visit(url)
        browser.goto URI.join(self.class.base_uri, url).to_s
      end

      def self.base_uri
        "http://localhost:#{APP_PORT}"
      end

      def self.start
        start_app
      end

      def self.in_ci?
        ENV['BUILD_ID']
      end

      def self.start_app
        FileUtils.cd APP_BASE do
          clean_rubyopt = (ENV['RUBYOPT'] || '').split(' ').reject { |o| o =~ /bundler/ }.join(' ')
          bundle_env="BUNDLE_GEMFILE=\"#{APP_BASE}/Gemfile\" RUBYOPT=\"#{clean_rubyopt}\""
          system("#{bundle_env} bundle check > /dev/null")
          unless $? == 0 || in_ci?
            # don't lock unless bundler-327 is fixed
            system("#{bundle_env} bundle install")
          end
          fail "Test application bundle lock failed" unless $? == 0
          system("#{bundle_env} script/server -p #{APP_PORT} -d")
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

      def self.stop_culerity
        @browser.exit if @browser
        @culerity_server.close if @culerity_server
      end

      def self.stop
        stop_app
        stop_culerity
      end
    end
  end
end

After do
  self.class.culerity_server.clear_proxies
  browser.clear_cookies
end

World do
  Bcsec::Rails::Cucumber::World.new
end

# The application uses a separate bundle, so it needs to run in a
# completely separate process.  However, it doesn't change from test
# to test, so it doesn't need to be started and stopped with each
# test.
at_exit do
  Bcsec::Rails::Cucumber::World.stop
end
Bcsec::Rails::Cucumber::World.start
