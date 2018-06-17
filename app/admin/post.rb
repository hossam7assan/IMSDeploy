ActiveAdmin.register Post do
    permit_params :body, :student_id
    actions :index, :show 

    
  index do
    selectable_column
    id_column
    column :student
    column :body
 
    actions
  end

  filter :student_id


end
