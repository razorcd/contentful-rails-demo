class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :remote_id

      t.timestamps null: false
    end

    add_index :products, :remote_id
  end
end
