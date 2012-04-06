class CreateElibriStructure < ActiveRecord::Migration
  
  def change
    create_table :contributors do |t|
      t.integer :import_id
      t.integer :product_id
      t.string :role_name
      t.string :role
      t.string :from_language
      t.string :full_name
      t.string :title
      t.string :first_name
      t.string :last_name_prefix
      t.string :last_name
      t.string :last_name_postfix
      t.text :biography

      t.timestamps
    end

    create_table :product_texts do |t|
      t.integer :import_id
      t.integer :product_id
      t.text :text
      t.string :text_type
      t.string :text_author
      t.string :source_title
      t.string :resource_link

      t.timestamps
    end

    create_table :products do |t|
      t.string :record_reference, :null => false
      t.string :isbn
      t.string :title
      t.string :full_title
      t.string :trade_title
      t.string :original_title
      t.integer :number_of_pages
      t.integer :duration
      t.integer :width
      t.integer :height
      t.string :cover_type
      t.string :edition_statement
      t.string :price_amount
      t.integer :vat
      t.string :pkwiu
      t.string :current_state
      t.string :product_form
      t.boolean :preview_exists, :default => false
      t.boolean :no_contributor, :default => false
      t.boolean :unnamed_persons, :default => false
      t.text :old_xml
      t.timestamps
    end
        
  end
end
