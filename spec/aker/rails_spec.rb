require File.expand_path("../../spec_helper", __FILE__)

describe Aker::Rails do
  describe "::VERSION" do
    it "exists" do
      lambda { Aker::Rails::VERSION }.should_not raise_error
    end

    it "has three or four dot-separated parts" do
      Aker::Rails::VERSION.split('.').size.should be_between(3, 4)
    end
  end
end
