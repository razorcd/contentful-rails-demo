require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  context "#index" do
    it "should return a list of products" do
      expect(Product).to receive_message_chain(:order, :eager_load, :all).
          with(any_args).and_return([{id: "123", name: "name123"}])

      get :index
      expect(response.body).to eq "[{\"id\":\"123\",\"name\":\"name123\"}]"
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
      expect(Contentful).to receive_message_chain(:new, :reset_to_initial!)
      expect(Contentful).to receive_message_chain(:new, :syncronize_products!)

      get :reset_and_sync_all
      expect(response.code).to eq "200"
    end
  end
end

