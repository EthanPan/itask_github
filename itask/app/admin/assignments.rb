ActiveAdmin.register Assignment do
 show do |a|
      attributes_table do
        row :id
        row :title 
        row :desp
        row :course_year do
        	link_to(a.course_year.year+" | "+a.course_year.course.name,admin_course_year_path(a.course_year))
        end
      end
      active_admin_comments
 end
 form do |f|                         
    f.inputs "New Assignment" do       
      f.input :course_year  ,:as => :select , :collection => Hash[CourseYear.all.map{|cy| [cy.year+" | "+cy.semester+" | "+cy.course.name,cy.id ]}]#CourseYear.all       
      f.input :user
      f.input :title               
      f.input :desp  
      f.input :open_time 
       f.input :end_time 
    end                               
    f.buttons                         
  end  
end
