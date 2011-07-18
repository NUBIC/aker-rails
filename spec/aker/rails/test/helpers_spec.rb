require File.expand_path("../../../../spec_helper", __FILE__)
require 'action_controller'
require 'action_controller/test_process'

module Aker::Rails::Test
  describe Helpers do
    before do
      Aker.configure do
        s = Aker::Authorities::Static.new

        s.valid_credentials!(:user, "jo", "50-50")
        authorities s
      end

      @test_case = Class.new do
        include Aker::Rails::Test::Helpers

        def request
          @request ||= ActionController::TestRequest.new
        end
      end.new
    end

    describe "#login_as" do
      it "logs in a user by username" do
        @test_case.login_as("jo")

        @test_case.request.env['aker.check'].user.username.should == "jo"
      end

      it "accepts Aker::User objects" do
        user = Aker::User.new("jo")

        @test_case.login_as(user)

        @test_case.request.env['aker.check'].user.should == user
      end
    end
  end
end
