require 'mechanize'
require 'logger'

module Aker::Rails::Cucumber
  ##
  # Provides helpers & a DSL for testing a deployed set of
  # applications with Mechanize.
  module MechanizeTest
    def agent
      @agent ||= Mechanize.new { |a|
        a.log = Logger.new("#{tmpdir}/mechanize.log")
        # Default to simulating interactive access
        a.user_agent_alias = 'Linux Firefox'
      }
    end

    def page
      @page or raise "No page has been requested yet"
    end

    def headers
      @headers ||= { 'Accept' => 'text/html' }
    end

    def header(name, value)
      if value
        headers[name] = value
      else
        headers.delete name
      end
    end

    def get(url)
      begin
        @page = agent.get(app_url(url), [], nil, headers)
      rescue Mechanize::ResponseCodeError => e
        @page = e.page
      end
      @headers = nil
    end

    def post(url)
      begin
        @page = agent.post(app_url(url), {}, headers)
      rescue Mechanize::ResponseCodeError => e
        @page = e.page
      end
      @headers = nil
    end

    def submit(form, button=nil)
      button ||= form.buttons.first
      begin
        @page = agent.submit(form, button, headers)
      rescue Mechanize::ResponseCodeError => e
        @page = e.page
      end
      @headers = nil
    end
  end
end
