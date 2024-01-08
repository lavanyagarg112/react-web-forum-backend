class DropTagging < ActiveRecord::Migration[7.1]
  def change
    drop_table :taggings
  end
end
