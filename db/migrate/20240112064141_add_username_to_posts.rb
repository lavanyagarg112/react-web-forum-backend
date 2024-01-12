class AddUsernameToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :username, :string
  end
end
