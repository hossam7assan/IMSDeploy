ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role, :rolesupervisorcancreate, :social_no , :name,  track_ids: []

  controller do 
    def create  
       if(params[:admin_user][:role] == "Supervisor")
         @uniq_supervisor = Staff.where(track_id:params[:admin_user][:track_ids])
           if(@uniq_supervisor.empty?)
               super
           else 
            flash[:notice] = "there is another supervisor assigned to the track"
            redirect_to :action => :new
            end
          else
            super
        end
    end
  end


  controller do 
  def update  
    if(params[:admin_user][:role] == "Supervisor")
      @uniq_supervisor = Staff.where(track_id:params[:admin_user][:track_ids])
        if(@uniq_supervisor.empty?)
            super
        else 
         flash[:notice] = "there is another supervisor assigned to the track"
         redirect_to :action => :edit
         end
       else
         super
     end
 end
end

controller do
  def index
puts "djjjjjjjjjjjjjjjjj"
   if current_admin_user.role == "Manager"
      @users = AdminUser.where(:role => "Manager")
   else
      @users = AdminUser.where(:role => "Instructor")
   end
      index!
  end
end 

    after_create do |user|
      if current_admin_user.role == "Supervisor"
        @role = ActiveRecord::Base.connection.exec_query("update admin_users set role = 'Instructor' where id = '#{@admin_user.id}'")
      end
      if (params[:admin_user][:role]=='Supervisor')
      @trackid=  params[:admin_user][:track_ids]
      @staff = ActiveRecord::Base.connection.exec_query("insert into staffs (admin_user_id, track_id, created_at, updated_at) values ('#{@admin_user.id}', #{@trackid}, '#{@admin_user.created_at}', '#{@admin_user.updated_at}')")
      else
        if (params[:admin_user][:role]=='Instructor')
          puts "L mfrod yb2a 3ndy aktr mn track"
        end
      end

    end

    after_update do |user|
      if current_admin_user.role == "Supervisor"
        @role = ActiveRecord::Base.connection.exec_query("update admin_users set role = 'Instructor' where id = '#{@admin_user.id}'")
      end
      
      if (params[:admin_user][:role]=='Supervisor')
      @trackid=  params[:admin_user][:track_ids]
      @staff = ActiveRecord::Base.connection.exec_query("update staffs set track_id = '#{@trackid}' where admin_user_id = '#{@admin_user.id}'")
 
    else
        if (params[:admin_user][:role]=='Instructor')
          puts "L mfrod yb2a 3ndy aktr mn track"
        end
      end
    end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :name
    column :role
    column :track
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at


  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      if current_admin_user.role == "Manager"
      f.input :role, :as => :select 
      end
      f.input :social_no
      if current_admin_user.role == "Manager"
      f.input :tracks, :as => :radio, collection => Track.all
      end
    end
    f.actions
  end

end
