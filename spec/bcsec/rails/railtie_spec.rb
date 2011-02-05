require File.expand_path("../../../spec_helper", __FILE__)

module Bcsec::Rails
  describe Railtie do
    it "uses Rails' logger for Bcsec logging"

    it "installs the Bcsec middleware"

    it "sets up a to_prepare hook for Bcsec::Rails::Application"
  end
end
