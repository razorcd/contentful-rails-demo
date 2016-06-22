require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  context "#index" do
    it "should return a list of products" do
      product= OpenStruct.new({id: "123", name: "name123", categories: []})
      expect(Product).to receive_message_chain(:order, :eager_load, :all).
          with(any_args).and_return([product])

      get :index
      expect(response.body).to eq(
        "[{\"id\":\"123\",\"name\":\"name123\",\"remote_id\":null,\"slug\":null," \
        "\"description\":null,\"size_type_color\":null,\"price\":null,\"quantity\":null,"\
        "\"sku\":null,\"website\":null,\"categories\":[],\"asset\":null,\"tags\":[]}]"
      )
    end
  end

  context "#sync_all" do
    it "should trigger a full products sync" do
      expect(Contentful).to receive_message_chain(:new, :syncronize_products!)

      get :sync_all
      expect(response.code).to eq "200"
    end
  end

  context "#reset_and_sync_all" do
    it "should trigger a full products reset and sync" do
      expect(ResourceCleaner).to receive(:wipe_all)
      expect(Contentful).to receive_message_chain(:new, :reset_to_initial_url!)
      expect(Contentful).to receive_message_chain(:new, :syncronize_products!)

      get :reset_and_sync_all
      expect(response.code).to eq "200"
    end
  end
end

