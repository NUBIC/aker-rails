require File.expand_path('../../../spec_helper', __FILE__)

module Aker::Rails
  describe ConfigurationExt do
    it 'is automatically mixed into Rails::Application::Configuration' do
      ::Rails::Application::Configuration.ancestors.should include(Aker::Rails::ConfigurationExt)
    end

    subject { ::Rails::Application::Configuration.new }

    before do
      Aker.configure { api_mode :http_basic }
    end

    after do
      Aker.configuration = nil
    end

    describe '#aker' do
      it 'returns the global Aker configuration' do
        subject.aker.api_modes.should == [:http_basic]
      end

      describe 'with a block' do
        before do
          subject.aker {
            portal :bar
          }
        end

        it 'updates the global configuration' do
          Aker.configuration.portal.should == :bar
        end

        it 'does not affect other settings' do
          Aker.configuration.api_modes.should == [:http_basic]
        end
      end
    end

    describe '#aker=' do
      it 'replaces the global Aker configuration' do
        subject.aker = Aker::Configuration.new { portal :foo }

        Aker.configuration.portal.should == :foo
        Aker.configuration.api_modes.should == []
      end
    end
  end
end
