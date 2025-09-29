class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :handle
      t.text :bio
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :accounts, :handle, unique: true
  end
end
