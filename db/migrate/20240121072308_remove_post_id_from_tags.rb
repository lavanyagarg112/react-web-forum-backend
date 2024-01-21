class RemovePostIdFromTags < ActiveRecord::Migration[7.1]
  def change
    remove_column :tags, :post_id, :bigint
  end
end
