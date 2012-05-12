class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :firstname
      t.string :lastname
      t.text :bio
      t.timestamps
    end
    add_index :users, :email,     :unique => true
    add_index :users, :nickname,  :unique => true
  end
end
