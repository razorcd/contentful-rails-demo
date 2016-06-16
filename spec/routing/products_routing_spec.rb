require "spec_helper"

describe "routes for Product" do
  it "routes /products to the products controller" do
    expect({ :get => "/products" }).to route_to(:controller => "products", :action => "index")
  end
end
