class CreateUserData < ActiveRecord::Migration[7.1]
  def change
    create_table :user_data do |t|
      t.string :authorname
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
