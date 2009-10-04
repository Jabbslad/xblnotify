# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_xblnotify_session',
  :secret      => 'dd4571cfe52acfa1dccc91beb7250363f6907447f3a3cdac85e235dbaba4c1cbe31cd6d0633fd95d0b180d5e2b53a1712860ea928d7bf3492dd51048547e2685'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
