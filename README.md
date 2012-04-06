# Elibri Connect gem #

## Continuous integration status ##
### Elibri dependencies:  ###
Elibri Xml Versions: [![Build Status](https://secure.travis-ci.org/elibri/elibri_xml_versions.png?branch=master)](http://travis-ci.org/elibri/elibri_xml_versions)  
Elibri Onix Mocks: [![Build Status](https://secure.travis-ci.org/elibri/elibri_onix_mocks.png?branch=master)](http://travis-ci.org/elibri/elibri_onix_mocks)  
Acts as Elibri Product: [![Build Status](https://secure.travis-ci.org/elibri/acts_as_elibri_product.png?branch=master)](http://travis-ci.org/elibri/acts_as_elibri_product)  

### Elibri Connect: ###
[![Build Status](https://secure.travis-ci.org/elibri/elibri_connect.png?branch=master)](http://travis-ci.org/elibri/elibri_connect)


## Description ##

Gem designed to allow easy addition of elibri based product system to your application.
Currently tested and support only on REE - due to dependencies.

## Usage ##

* add `gem 'elibri_connect'` to you Gemfile  
* run `bundle install`  

Now - depending on your situation you may choose one of four options:  

* `rails generate elibri:connect:config` to create only configuration file in initializers, in which you need to supply your own user/password combination.  
* `rails generate elibri:connect:db_structure` to create db structure and models (product, contributor and product_text), which will have turned on elibri synchronisation.  
* `rails generate elibri:connect:whenever` to create config/schedule.rb file, which will invoke elibri sync every 6 hours. It will overwrite your actual config/schedule.rb - so please be careful.  
* `rails generate elibri:connect:install` which will invoke all three previous generators.  

If you have working application, and you need to add support to existing product model - please look here for more information about adding acts_as_elibri_product declaration to model (including traverse vector examples): [elibri/acts_as_elibri_product](https://github.com/elibri/acts_as_elibri_product)

After creation of config file, gem will provide you with rake task: `rake elibri:update_products` which will connect to elibri, download new and update existing product. You can also use it from your code using `Elibri::Connect.update_products!` method.  
If you need to access raw api client - you can get it by invoking `Elibri::Connect.api_client`.  

Gem has additional mode of operation called test_mode - you can get into it, by setting `test_mode=true` inside configuration file. When using it your application will not connect to elibri, instead it will use elibri_xml_mocks to mock and create product for your app.

## Anatomy of config file ##

Config file looks like this, and needs to be in config/initializers directory (generate command can provide one for you):  

```ruby
Elibri::Connect.setup do |config|
  config.login = your elibri api login here
  config.password = your elibri api password here
  config.api_version = 'v1' #api_version - doesn't need to be changed
  config.onix_dialect = '3.0.1' #onix_dialect - doesn't need to be changed
  config.product_model = :product #if you use other model than product - you need to set different name here
  config.test_mode = true #- add this line to config if you want to avoid connecting to elibri and use mocked data
end
```