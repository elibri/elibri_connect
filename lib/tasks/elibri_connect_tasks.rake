# desc "Explaining what the task does"
# task :elibri_connect do
#   # Task goes here
# end

namespace :elibri do
  desc "Load products from elibri - creating and updating product where needed"
  task :update_products => :environment do
    Elibri::Connect.update_products!
  end
end