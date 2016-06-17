require "spec_helper"

describe "routes for Product" do
  it "routes /products to the products controller" do
    expect({ :get => "/products" }).to route_to(:controller => "products", :action => "index")
    expect({ :get => "/products/sync_all" }).to route_to(:controller => "products", :action => "sync_all")
  end
end
