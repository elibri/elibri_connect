Elibri::Connect.setup do |config|
  config.login = 'login'
  config.password = 'password'
  config.api_version = 'v1'
  config.onix_dialect = '3.0.1'
  config.test_mode = true
  config.product_model = :product
end