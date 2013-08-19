##
# This file, being the same name as its parent gem, is required via
# `Bundler.require` by the stock `config/application.rb` in a Rails 4
# application.
#
# (Just a note as to why this file works: Railtie registration is implemented
# via a subclassing callback.  See `Rails::Railtie.inherited`.)
#
# If you change the `Bundler.require` behavior in your application's
# `config/application.rb` such that `aker-rails` is not loaded, you will have
# to load `aker/rails/railtie` yourself.
require 'aker/rails/railtie'
