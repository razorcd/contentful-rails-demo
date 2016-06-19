require "rails_helper"

RSpec.describe Contentful::ItemFactory::CategoryItem do
  context "#syncronize_db!" do
    it "should create or update a Category record" do
      category_doule = instance_double(Category)
      expect(Category).to receive(:find_or_create_by).with(remote_id: "some_id_here").and_return(category_doule)
      expect(category_doule).to receive(:update!).with({
          title: "title_here",
          description: "categoryDescription_here",
        })

      category_item = Contentful::ItemFactory::CategoryItem.new({
            "sys" => {"id" => "some_id_here"},
            "fields" => {
              "title" => {"en-US" => "title_here"},
              "categoryDescription" => {"en-US" => "categoryDescription_here"},
            }
          })
      category_item.syncronize_db!
    end
  end
end


