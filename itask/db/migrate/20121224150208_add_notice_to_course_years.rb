class AddNoticeToCourseYears < ActiveRecord::Migration
  def change
  	add_column :course_years, :notice, :string
  end
end
