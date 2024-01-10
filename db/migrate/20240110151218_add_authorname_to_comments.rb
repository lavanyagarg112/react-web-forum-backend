class AddAuthornameToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :author_name, :string
  end
end
