# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_league_manager_session',
  :secret      => '0e0d99ee36416ab41c4f109211543b53a236699598652f8aca09b3769e11e1ea48df77cd7f97c271f17561f6fe24b61cd5b00114fc549083582de719ec7c5bce'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
