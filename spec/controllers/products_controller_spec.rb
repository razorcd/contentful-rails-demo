require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  context "#index" do
    it "should return a list of products" do
      expect(Product).to receive(:all).and_return([{id: "123", name: "name123"}])

      get :index
      expect(response.body).to eq "[{\"id\":\"123\",\"name\":\"name123\"}]"
    end
  end
end

