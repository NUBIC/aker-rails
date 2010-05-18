require File.expand_path("../../../spec_helper", __FILE__)
require 'rack'

module Bcsec::Rails
  class SomeController
    attr_accessor :request

    def initialize(request)
      @request = request
    end

    def self.before_filter(*args)
      self.before_filters.concat(args)
    end

    def self.before_filters
      @before_filters ||= []
    end

    include Bcsec::Rails::SecuredController
  end

  describe SecuredController do
    describe "deprecated alias" do
      it "is aliased as Bcsec::SecuredController" do
        ::Bcsec::Rails::SecuredController.should == ::Bcsec::SecuredController
      end

      it "warns about using Bcsec::SecuredController" do
        ::Bcsec::SecuredController
        deprecation_message.should =~
          /Use Bcsec::Rails::SecuredController instead of Bcsec::SecuredController.*2.2/
      end
    end

    before do
      @request = Rack::Request.new(Rack::MockRequest.env_for("/some"))
      @bcsec = (@request.env['bcsec'] = mock)
      @controller = SomeController.new(@request)
    end

    describe "#bcsec_authorize" do
      it "is registered as a filter" do
        @controller.class.before_filters.should == [:bcsec_authorize]
      end

      it "invokes authentication_required on the bcsec rack facade" do
        @bcsec.should_receive(:authentication_required!)
        @controller.bcsec_authorize
      end
    end

    # filter behavior is further characterized in integrated tests
  end
end
