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

    context "when the form UI mode is in use" do
      context "and a /login route is defined" do
        it "instructs Bcsec to not use its built-in login form" do
          pending "need to figure out a good way to test railties"
        end
      end

      context "and a /logout route is defined" do
        it "instructs Bcsec to not use its built-in logout screen" do
          pending "need to figure out a good way to test railties"
        end
      end
    end
  end
end
