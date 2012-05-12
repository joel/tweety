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
  end
end
