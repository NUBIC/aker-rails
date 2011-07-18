require File.expand_path("../../../spec_helper", __FILE__)
require 'rack'

module Aker::Rails
  class SomeController
    attr_accessor :request

    def initialize(request)
      @request = request
    end

    def self.before_filter(*args, &block)
      filter =
        if block
          block
        else
          args.shift
        end
      self.before_filters << [filter, *args]
    end

    def self.before_filters
      @before_filters ||= []
    end

    include Aker::Rails::SecuredController
  end

  describe SecuredController do
    describe "deprecated alias" do
      it "is aliased as Aker::SecuredController" do
        ::Aker::Rails::SecuredController.should == ::Aker::SecuredController
      end

      it "warns about using Aker::SecuredController" do
        ::Aker::SecuredController
        deprecation_message.should =~
          /Use Aker::Rails::SecuredController instead of Aker::SecuredController.*2.2/
      end
    end

    before do
      @request = Rack::Request.new(Rack::MockRequest.env_for("/some"))
      @aker = (@request.env['aker'] = mock)
      @controller = SomeController.new(@request)
    end

    describe "#aker_authorize" do
      it "is registered as a filter" do
        @controller.class.before_filters.should == [ [:aker_authorize] ]
      end

      it "invokes authentication_required on the aker rack facade" do
        @aker.should_receive(:authentication_required!)
        @controller.aker_authorize
      end
    end

    describe ".permit" do
      it "adds a filter" do
        @controller.class.permit(:foo, :quux)
        @controller.class.should have(2).before_filters
        @controller.class.before_filters.last[0].class.should == Proc
      end

      describe "and options" do
        it "passes options on to before_filter" do
          @controller.class.permit(:foo, :quux, :only => :zamm)
          @controller.class.before_filters.last[1].should == { :only => :zamm }
        end

        it "passes empty options if no options are specified" do
          @controller.class.permit(:foo, :quux, :vom)
          @controller.class.before_filters.last[1].should == {}
        end
      end
    end

    # filter behavior is further characterized in integrated tests
  end
end
