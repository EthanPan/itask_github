class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.column :teach_id, :string
  		t.column :name, :string
  		t.column :sex,:boolean
  		t.column :password, :string
  		t.column :email, :string
      t.timestamps
    end    
    add_index :teachers, :teach_id, :unique => true
    
  end
end
