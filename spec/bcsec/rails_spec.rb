require File.expand_path("../../spec_helper", __FILE__)

describe Bcsec::Rails do
  describe "::VERSION" do
    it "exists" do
      lambda { Bcsec::Rails::VERSION }.should_not raise_error
    end

    it "has three or four dot-separated parts" do
      Bcsec::Rails::VERSION.split('.').size.should be_between(3, 4)
    end
  end
end
