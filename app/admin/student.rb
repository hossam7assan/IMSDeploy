ActiveAdmin.register Student do

    permit_params :email, :password, :password_confirmation, :name, :birth, :mobile, :gender, :avatar, :group_id,  track_ids: []

  controller do 
    def create
      super 
      # track_id = 1
    end
  end
     before_create do |order|
       params[:tracks] = params[:student][:track_ids]
     end

    after_create do |user|
      unless @student.id.blank?
        if current_admin_user.role != "Supervisor"
        @trackid= params[:student][:track_ids]
        else 
          @tracks_data= Staff.where(admin_user_id: current_admin_user.id).take
          @trackid = @tracks_data.track_id
        end
        UserNotifierMailer.welcome_email(@student).deliver_now
        @list = ActiveRecord::Base.connection.exec_query("insert into lists (student_id, track_id, created_at, updated_at) values ('#{@student.id}', #{@trackid}, '#{@student.created_at}', '#{@student.updated_at}')")
      end
    end

    after_update do |user|
      if current_admin_user.role != "Supervisor"
      @trackid=  params[:student][:track_ids]
      else 
        @tracks_data= Staff.where(admin_user_id: current_admin_user.id).take
        @trackid = @tracks_data.track_id
      end

      @list = ActiveRecord::Base.connection.exec_query("update lists set track_id = '#{@trackid}' where student_id = '#{@student.id}'")
    end
  controller do 
    def destroy 
      student = Student.find(params[:id])
      sttrack = List.where(student_id: params[:id])
      student.destroy!

      
      sttrack = List.find(sttrack[0]["id"])
      sttrack.destroy!
    end  
  end


  index do
    selectable_column
    id_column
    column :name
    column :email
    column :birth
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :birth
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :gender, :as => :select 
      f.input :birth, :as => :datepicker
      f.input :avatar
      f.input :mobile
      if current_admin_user.role != "Supervisor"
      f.input :tracks, :as => :radio, collection => Track.all
      end
      f.input :group
    end
    f.actions
  end

end
