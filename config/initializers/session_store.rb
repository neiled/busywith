# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_busywith_session',
  :secret      => 'd7bacdbb0bb37b858ba58dfa3fe1086063662d663e86a5363d95deb7e7530355256059cc93e8134766d5364d307809d264dba32eb69762909a930e5d1e1d2ffd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
