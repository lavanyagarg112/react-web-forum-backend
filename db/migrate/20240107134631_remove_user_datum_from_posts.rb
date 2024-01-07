class RemoveUserDatumFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :posts, :user_datum, index: true, foreign_key: true
  end
end
