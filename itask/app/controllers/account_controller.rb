class AccountController < ApplicationController     
  def login
    if request.post?  

       @student = Student.find_by_stu_id_and_password(params[:stu_id],params[:password])
         if @student  
             flash[:success] = "login successfully!"   
         else
            flash[:alert] = "the stu_id or password is wrong"
         end  
        
         
     
     end
     
  end
  def register
    @student = Student.new
  end
end
