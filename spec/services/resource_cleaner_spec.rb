require "rails_helper"

RSpec.describe ResourceCleaner do
  context "#wipe_all" do
    it "it should run delete on all resources" do
      expect(Product).to receive(:delete_all)
      expect(Tag).to receive(:delete_all)
      expect(Category).to receive(:delete_all)
      expect(Asset).to receive(:delete_all_and_remove_files)

      ResourceCleaner.wipe_all
    end
  end
end
