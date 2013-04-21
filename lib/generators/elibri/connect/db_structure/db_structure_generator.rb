require 'rails/generators'
require 'rails/generators/migration'

module Elibri
  module Connect
    class DbStructureGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      desc "This generator creates basic models and database structure for using elibri"
      def create_elibri_db_structure
        create_file "app/models/contributor.rb", 
    %Q{class Contributor < ActiveRecord::Base

      belongs_to :product, :touch => true

      attr_accessible :import_id, :role_name, :role, :from_language, :full_name, :title, :first_name, 
                          :last_name_prefix, :last_name, :last_name_postfix, :biography
    end}
        create_file "app/models/product_text.rb",
    %Q{class ProductText < ActiveRecord::Base

      belongs_to :product, :touch => true

      attr_accessible :import_id, :text, :text_type, :text_author, :source_title, :resource_link

    end}
    
        create_file "app/models/related_product.rb",
      %Q{class RelatedProduct < ActiveRecord::Base
        attr_accessible :onix_code, :product_id, :related_record_reference

        belongs_to :product

        def object
          Product.where(:record_reference => related_record_reference).first
        end

        def self.objects
          joins(:product).first.product.related_products.map { |x| Product.where(:record_reference => x.related_record_reference).first }.compact
        end

      end}
        
        create_file "app/models/product.rb",
    %Q[class Product < ActiveRecord::Base

      with_options :autosave => true, :dependent => :destroy do |product|
        product.has_many :contributors
        product.has_many :product_texts
        product.has_one :imprint
        product.has_many :related_products
      end
      
      HEIGHT_UNIT = 'mm'
      WIDTH_UNIT = 'mm'
      THICKNESS_UNIT = 'mm'
      WEIGHT_UNIT = 'gr'
      FILE_SIZE_UNIT = 'MB'
      DURATION_UNIT = 'min'

      attr_accessible :isbn, :title, :full_title, :trade_title, :original_title, :publication_year,
                      :publication_month, :publication_day, :number_of_pages, :width, :height, 
                      :cover_type, :edition_statement, :audience_age_from, :audience_age_to, 
                      :price_amount, :vat, :current_state, :product_form, :old_xml

      #on left side elibri attributes, on right side our name of attribute               
      acts_as_elibri_product :record_reference => :record_reference, #very important attribute!
             :isbn13 => :isbn,
             :title => :title,
             :full_title => :full_title,
             :trade_title => :trade_title,
             :original_title => :original_title,
             :number_of_pages => :number_of_pages,
             :duration => :duration,
             :width => :width,
             :height => :height,
             :cover_type => :cover_type,
             :pkwiu => :pkwiu,
             :edition_statement => :edition_statement,
             :cover_price => :price_amount,
             :vat => :vat,
             :product_form => :product_form,
             :no_contributor? => :no_contributor,
             :unnamed_persons? => :unnamed_persons,
             :contributors => { #name in elibri
               :contributors => { #name in our db
                 :id => :import_id,
                 :role_name => :role_name,
                 :role => :role,
                 :from_language => :from_language,
                 :person_name => :full_name,
                 :titles_before_names => :title,
                 :names_before_key => :first_name,
                 :prefix_to_key => :last_name_prefix,
                 :key_names => :last_name,
                 :names_after_key => :last_name_postfix,
                 :biographical_note => :biography
               }
             },
             :related_products => {
                :related_products => {
                  :record_reference => :related_record_reference,
                  :relation_code => :onix_code
                }
              },
             :text_contents => {
               :product_texts => {
                 :id => :import_id,
                 :text => :text,
                 :type_name => :text_type,
                 :author => :text_author,
                 :source_title => :source_title,
                 :source_url => :resource_link
               }
             }
    ]
        migration_template "create_elibri_structure.rb", "db/migrate/create_elibri_structure.rb"
      end
  
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
  
    end
  end
end