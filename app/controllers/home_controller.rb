class HomeController < ApplicationController
  before_action :authenticate_admin_user|authenticate_student!
  def index
    session[:conversations] ||= []

    @students = Student.all.where.not(id: current_student)
    @conversations =Conversation.includes(:recipient, :messages)
    .find(session[:conversations])
  end
  def current_user
     if current_student.present? 
        @user = current_student.id
        render json: @user   
      end
  end  
end
