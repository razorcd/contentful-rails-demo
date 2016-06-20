class ResourceCleaner
  def self.wipe_all
    ActiveRecord::Base.transaction do
      products= Product.delete_all
      products= Tag.delete_all
      products= Category.delete_all
      products= Asset.delete_all_and_remove_files
    end
  end
end
