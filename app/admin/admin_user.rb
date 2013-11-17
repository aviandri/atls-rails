ActiveAdmin.register AdminUser do     
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
      f.input :roles, :as => :check_boxes, :collection => AdminUser::ROLES       
    end                               
    f.buttons                         
  end         

  controller do
    def max_csv_records; @per_page; end
  end
                          
end                                   
