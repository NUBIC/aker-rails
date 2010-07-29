require File.join(File.dirname(__FILE__), %w(.. test))

##
# Helpers for common test tasks.
#
# To use these helpers with a Rails application using RSpec:
#
#     # spec/spec_helper.rb
#     Spec::Runner.configure do |config|
#       config.include Bcsec::Rails::Test::Helpers
#       ...
#     end
module Bcsec::Rails::Test::Helpers
  include Bcsec::Test::Helpers

  ##
  # Logs in a user.
  #
  # User objects can be constructed by creating `Bcsec::User` instances, or by
  # using the return value of
  #
  #     Bcsec.authority.valid_credentials?(:user, username, password)
  #
  # @param [Bcsec::User] user an object representing the user to log in
  def login_as(user)
    request.env.merge!(login_env(user))
  end
end
