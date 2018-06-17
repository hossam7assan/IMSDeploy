ActiveAdmin.register Event do
    permit_params :title, :body, :admin_user_id
controller do
  def new
    @event = Event.new
    @event.admin_user_id = current_admin_user.id
  end
end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :admin_user_id, as: :hidden
    end
    f.actions
  end

end
