# config/initializers/session_store.rb

Rails.application.config.session_store :cookie_store, key: '_my_unique_app_session', domain: :all, tld_length: 2, same_site: :none, secure: true

