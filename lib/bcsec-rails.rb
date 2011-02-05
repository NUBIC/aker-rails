##
# This file, being the same name as its parent gem, is required via
# `Bundler.require` by the stock `config/application.rb` in a Rails 3
# application.
#
# (Just a note as to why this file works: Railtie registration is implemented
# via a subclassing callback.  See `Rails::Railtie.inherited`.)
#
# If you change the `Bundler.require` behavior in your application's
# `config/application.rb` such that `bcsec-rails` is not loaded, you will have
# to load `bcsec/rails/railtie` yourself.
require 'bcsec/rails/railtie'
