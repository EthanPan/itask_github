ActiveAdmin.register User do
   index do                            
    column :id                     
    column :user_num        
    column :name           
    column :email             
    default_actions                   
  end 

  form do |f|                         
    f.inputs "Edit User" do       
      f.input :user_num  
      f.input :name
      f.input :email
      f.input :role_ids ,:collection => Hash[Role.all.map{|r| [r.name,r.id ]}] 
      end                               
    f.buttons                         
  end  

end
