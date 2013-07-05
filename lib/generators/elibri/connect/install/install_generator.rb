# -*- encoding : utf-8 -*-
module Elibri
  module Connect
    class InstallGenerator < Rails::Generators::Base
  
      desc "This generator installs and elibri product system in application - including db structure, models and config file"
      def install
        Rails::Generators.invoke("elibri:connect:config")
        Rails::Generators.invoke("elibri:connect:db_structure")
        Rails::Generators.invoke("elibri:connect:whenever")
        rake('db:migrate')
      end
    end
  end
end
