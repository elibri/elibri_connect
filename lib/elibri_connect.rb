require 'acts_as_elibri_product'
require 'elibri_api_client'
require 'elibri_onix_mocks'

require 'elibri_connect/railtie'

module Elibri
  module Connect
  
    class << self
      attr_accessor :login, :password, :api_version, :onix_dialect, :test_mode, :product_model
    end
    
    def self.setup(&block)
      yield self
    end
    
    def self.api_client
      Elibri::ApiClient.new(:login => login, :password => password, 
                                  :api_version => api_version, :onix_dialect => onix_dialect)
    end
    
    def self.update_products!
      if test_mode
        book = Elibri::XmlMocks::Examples.book_example
        (self.product_model).to_s.capitalize.constantize.batch_create_or_update_from_elibri(Elibri::ONIX::XMLGenerator.new(book).to_s)
      else
        api = Elibri::ApiClient.new(:login => login, :password => password, 
                                    :api_version => api_version, :onix_dialect => onix_dialect)
        api.refill_all_queues! 
        while (queue = api.pending_queues.find { |q| q.name == 'meta' })    
          response = api.pop_from_queue('meta', :count => 25)                            
          (self.product_model).to_s.capitalize.constantize.batch_create_or_update_from_elibri(response.onix)
        end
      end
    end
  
  end
end