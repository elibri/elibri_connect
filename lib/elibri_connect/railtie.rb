# -*- encoding : utf-8 -*-
require 'elibri_connect'
require 'rails'
module ElibriConnect
  class Railtie < Rails::Railtie
    railtie_name :elibri_connect

    rake_tasks do
      load "tasks/elibri_connect_tasks.rake"
    end
  end
end
