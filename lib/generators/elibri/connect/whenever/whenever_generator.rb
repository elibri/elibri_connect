module Elibri
  module Connect
    class WheneverGenerator < Rails::Generators::Base
      desc "This generator creates an elibri whenever file, adding into cron and updating products every 6 hours"
      def whenever
        create_file "config/schedule.rb", 
    %Q{every 6.hours do
      runner "Elibri::Connect.update_products"
    end}
      end
    end
  end
end
