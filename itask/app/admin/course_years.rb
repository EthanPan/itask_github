ActiveAdmin.register CourseYear do
  form do |f|                         
    f.inputs "New CourseYear" do       
      f.input :course  ,:as => :select , :collection => Hash[Course.all.map{|c| [c.name+" | Teacher:"+c.user.name,c.id ]}]
      f.input :year
      f.input :semester               
    
    end                               
    f.buttons                         
  end  
end
