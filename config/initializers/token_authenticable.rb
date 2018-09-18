Devise::TokenAuthenticatable.setup do |config|
  config.token_expires_in = 1.day
  config.should_reset_authentication_token = false
  config.should_ensure_authentication_token = true
end
