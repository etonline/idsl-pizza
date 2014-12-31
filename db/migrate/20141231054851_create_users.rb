class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :cellphone
      t.string :landphone
      t.string :address
      t.integer :bonus
      t.string :gender

      t.timestamps null: false
    end
  end
end
