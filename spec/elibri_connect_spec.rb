require 'spec_helper'

describe "Elibri::Connect" do
  
  it "should create product" do
   lambda do
     Elibri::Connect.update_products!
   end.should change(Product, :count)
  end
  
end