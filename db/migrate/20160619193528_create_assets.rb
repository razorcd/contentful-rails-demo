class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :remote_id
      t.string :title
      t.string :description
      t.string :remote_file_url

      t.timestamps null: false
    end
  end
end
