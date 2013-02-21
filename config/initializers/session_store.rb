# Be sure to restart your server when you modify this file.

PwdKeeperRails::Application.config.session_store :active_record_store, key: '_pwd-keeper-rails_session', :secret => '3f0e297ad3ed1dd66ad15807cd19adc3bbfcd9bf58713729662456fe6b74e7e630ffd3b69c0b57971d24b01d1213ea44ab7ffb426275248feeb6c72a383075d0'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# PwdKeeperRails::Application.config.session_store :active_record_store
