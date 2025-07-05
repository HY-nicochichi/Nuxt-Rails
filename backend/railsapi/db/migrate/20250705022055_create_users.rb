class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :pass_enc
      t.string :name

      t.timestamps
    end
  end
end
