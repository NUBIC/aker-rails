require File.join(File.dirname(__FILE__), %w(.. test))

module Bcsec::Rails::Test::Helpers
  include Bcsec::Test::Helpers

  def login_as(user)
    request.env.merge!(login_env(user))
  end
end
