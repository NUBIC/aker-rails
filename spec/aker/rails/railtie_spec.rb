require File.expand_path("../../../spec_helper", __FILE__)

module Aker::Rails
  describe Railtie do
    it "uses Rails' logger for Aker logging" do
      pending "need to figure out a good way to test railties"
    end

    it "installs the Aker middleware" do
      pending "need to figure out a good way to test railties"
    end

    it "sets up a to_prepare hook for Aker::Rails::Application" do
      pending "need to figure out a good way to test railties"
    end
  end
end
