require File.expand_path("../../../spec_helper", __FILE__)
require 'rack'
require 'action_controller'

module Bcsec::Rails
  class FakeApplicationController
    attr_accessor :request

    def self.helper_method(*names)
      helper_methods.concat(names)
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
      @env['bcsec'] = (@bcsec = mock)
      @controller.request = Rack::Request.new(@env)
    end

    it "adds current_user" do
      @bcsec.should_receive(:user).and_return(Bcsec::User.new("jo"))

      @controller.current_user.username.should == "jo"
    end

    it "defines current_user as a helper method" do
      @controller.class.helper_methods.should include(:current_user)
    end

    describe "#permit?" do
      it "delegates to the bcsec rack facade" do
        @bcsec.should_receive(:permit?).with(:bar, :quux)

        @controller.permit?(:bar, :quux)
      end

      it "passes a block to the bcsec rack facade, if present" do
        @bcsec.should_receive(:permit?).with(:bar, :quux).and_yield

        @controller.permit?(:bar, :quux) { 1 + 1 }.should == 2
      end

      it "is registered as a helper method" do
        @controller.class.helper_methods.should include(:permit?)
      end

      describe "permit alias" do
        it "exists" do
          @bcsec.should_receive(:permit?).with(:bar, :baz)

          @controller.permit(:bar, :baz)
        end

        it "is also registered as a helper method" do
          @controller.class.helper_methods.should include(:permit)
        end
      end
    end
  end
end
