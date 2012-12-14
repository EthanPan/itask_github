class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.column :stu_id, :string
  		t.column :name,   :string
  		t.column :sex, :boolean     #0 is woman,1 is man
  		t.column :password, :string
  		t.column :email, :string
      t.timestamps
    end
    add_index :students, :stu_id, :unique => true
   
  end
end
