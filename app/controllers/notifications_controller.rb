class NotificationsController < ApplicationController
  def index
    push_notifications(1 , 'khaled')
    @notifications = Notification.where("student_id = #{current_student.id}")
  end
  private 
  def push_notifications(id , notification)
    Pusher.trigger("notifications-#{id}", "new_notification", 
    { "body": notification} ) 
  end  

end
