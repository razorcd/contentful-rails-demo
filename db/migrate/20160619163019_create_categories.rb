class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :remote_id
      t.string :title
      t.string :description

      t.timestamps null: false
    end

    add_index :categories, [:remote_id]
  end
end
