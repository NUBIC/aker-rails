require File.join(File.dirname(__FILE__), %w(.. test))

##
# Helpers for common test tasks.
#
# To use these helpers with a Rails application using RSpec:
#
#     # spec/spec_helper.rb
#     Spec::Runner.configure do |config|
#       config.include Aker::Rails::Test::Helpers
#       ...
#     end
module Aker::Rails::Test::Helpers
  include Aker::Test::Helpers

  ##
  # Logs in a user.
  #
  # Users can be identified by:
  #
  # * their username
  # * building a `Aker::User` instance representing that user
  # * the return value of
  #
  #       Aker.authority.valid_credentials?(:user, username, password)
  #
  #   (which is a `Aker::User`)
  #
  # @param [String, Aker::User] user a user's username or `Aker::User` object
  def login_as(user)
    request.env.merge!(login_env(user))
  end
end
