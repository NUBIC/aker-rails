require File.expand_path("../../../spec_helper", __FILE__)
require 'rack'
require 'action_controller'

module Bcsec::Rails
  class FakeApplicationController
    attr_accessor :request

    def self.helper_method(name)
      helper_methods << name
    end

    def self.helper_methods
      @helper_methods ||= []
    end

    Bcsec.configure { }
    include Application
    Bcsec.configuration = nil
  end

  describe Application do
    before do
      @controller = FakeApplicationController.new

      @env = Rack::MockRequest.env_for('/')
      @controller.request = Rack::Request.new(@env)
    end

    it "adds current_user" do
      @env['bcsec'] = mock
      @env['bcsec'].should_receive(:user).and_return(Bcsec::User.new("jo"))

      @controller.current_user.username.should == "jo"
    end

    it "defines current_user as a helper method" do
      @controller.class.helper_methods.should include(:current_user)
    end

    it "adds the bcsec middleware to the action controller middleware stack" do
      ActionController::Dispatcher.middleware.should include(Bcsec::Rack::Setup)
    end
  end
end
