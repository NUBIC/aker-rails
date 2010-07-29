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
  # Users can be identified by:
  #
  # * their username
  # * building a `Bcsec::User` instance representing that user
  # * the return value of
  #   
  #       Bcsec.authority.valid_credentials?(:user, username, password)
  #
  #   (which is a `Bcsec::User`)
  #
  # @param [String, Bcsec::User] user a user's username or `Bcsec::User` object
  def login_as(user)
    request.env.merge!(login_env(user))
  end
end
