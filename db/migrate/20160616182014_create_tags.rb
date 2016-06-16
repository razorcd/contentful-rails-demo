class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :value, null: false

      t.timestamps null: false
    end
    add_index :tags, :value, unique: true

    create_table :products_tags, :id => false do |t|
        t.references :product
        t.references :tag
    end
    add_index :products_tags, [:product_id, :tag_id]

    copy_tags_to_new_table
  end

  def down
    drop_table :products_tags
    drop_table :tags
  end

private

  def copy_tags_to_new_table
      products_with_tags.each do |product|
      product_id = product["id"]
      tags = JSON.parse product["tags"]

      tags.each do |tag|
        tag_id = find_tag_id_for tag_value: tag
        unless tag_id
          insert_into_tags tag_value: tag
          tag_id = find_tag_id_for tag_value: tag || raise("tag_id for value '#{tag}' not found")
        end
        update_products_tags_joint_table product_id: product_id, tag_id: tag_id
      end
    end
  end

  def products_with_tags
    execute("SELECT id,tags FROM products;").select {|p| p["tags"]}
  end

  def find_tag_id_for tag_value:
    tag_id_record = ActiveRecord::Migration.execute <<~SQL
      SELECT id
      FROM tags
      WHERE value = "#{tag_value}"
      ;
    SQL
    tag_id = tag_id_record.first&.[]("id")
  end

  def insert_into_tags tag_value:
    ActiveRecord::Migration.execute <<~SQL
      INSERT OR REPLACE INTO "tags" ("value", "created_at", "updated_at")
      VALUES ("#{tag_value}", "#{Time.current}", "#{Time.current}")
      ;
    SQL
  end

  def update_products_tags_joint_table product_id:, tag_id:
    ActiveRecord::Migration.execute <<~SQL
      INSERT INTO "products_tags" ("product_id", "tag_id")
      VALUES ("#{product_id}", "#{tag_id}")
      ;
    SQL
  end
end
