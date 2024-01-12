class AddBioToUserDatum < ActiveRecord::Migration[7.1]
  def change
    add_column :user_data, :bio, :text
  end
end
