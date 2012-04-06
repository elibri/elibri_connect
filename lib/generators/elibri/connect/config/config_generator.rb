module Elibri
  module Connect
    class ConfigGenerator < Rails::Generators::Base
      desc "This generator creates an elibri configuration file at config/initializers"
      def create_config_file
        create_file "config/initializers/elibri_config.rb", 
    %Q{Elibri::Connect.setup do |config|
      config.login = 'login' #INSERT YOUR LOGIN HERE
      config.password = 'password' #INSERT YOUR PASSWORD HERE
      config.api_version = 'v1'
      config.onix_dialect = '3.0.1'
      config.product_model = :product #IF NEEDED CHANGE MODEL NAME HERE 
    end}
      end
    end
  end
end