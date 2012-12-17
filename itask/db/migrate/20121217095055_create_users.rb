class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
     t.column :user_num, :string
  		t.column :name,   :string
  		t.column :sex, :boolean     #0 is woman,1 is man
  		t.column :password, :string
  		t.column :email, :string
      t.timestamps
    end
        add_index :users, :user_num, :unique => true

  end
end
