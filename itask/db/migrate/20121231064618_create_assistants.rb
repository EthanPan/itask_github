class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
      t.column :course_year_id ,:integer
      t.column :user_id ,:integer
      t.column :desp ,:string
      t.timestamps
    end
  end
end
