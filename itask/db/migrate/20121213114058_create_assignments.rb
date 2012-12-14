class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.column :title,          :string
      t.column :desp,           :string
      t.column :course_year_id, :integer
      t.column :open_time,      :datetime
      t.column :end_time,       :datetime
       
      t.timestamps
    end
  end
end
