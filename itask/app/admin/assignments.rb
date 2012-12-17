ActiveAdmin.register Assignment do
 form do |f|                         
    f.inputs "New Assignment" do       
      f.input :course_year  ,:as => :select , :collection => Hash[CourseYear.all.map{|cy| [cy.year+" | "+cy.semester+" | "+cy.course.name,cy.id]}]#CourseYear.all       
      f.input :title               
      f.input :desp  
      f.input :open_time 
    end                               
    f.buttons                         
  end  
end
