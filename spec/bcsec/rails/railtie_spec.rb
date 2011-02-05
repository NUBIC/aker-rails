require File.expand_path("../../../spec_helper", __FILE__)

module Bcsec::Rails
  describe Railtie do
    it "uses Rails' logger for Bcsec logging" do
      pending "need to figure out a good way to test railties"
    end

    it "installs the Bcsec middleware" do
      pending "need to figure out a good way to test railties"
    end

    it "sets up a to_prepare hook for Bcsec::Rails::Application" do
      pending "need to figure out a good way to test railties"
    end
  end
end
