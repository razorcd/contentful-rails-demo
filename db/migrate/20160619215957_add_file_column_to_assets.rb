class AddFileColumnToAssets < ActiveRecord::Migration
  def up
    add_attachment :assets, :file
  end

  def down
    remove_attachment :assets, :file
  end
end



