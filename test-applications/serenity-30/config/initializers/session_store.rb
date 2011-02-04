# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_serenity-30_session',
  :secret      => '92794a3266bdc1ef5b31512ec5164edc619ea40c413b26fe69f5376936c5f579b15ca677c399fbfb5ec12fa93957b9954f6fa2c80513769230db319aa685f5fc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
