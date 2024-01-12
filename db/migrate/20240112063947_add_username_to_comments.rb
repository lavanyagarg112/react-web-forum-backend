class AddUsernameToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :username, :string
  end
end
