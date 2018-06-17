class MessagesController < ApplicationController
  def index
    if current_student.present? 
      session[:user_id] = current_student.id
      session[:user_model] = 'student'
    else
      session[:user_id] = current_admin_user.id
      session[:user_model] = 'admin'  
    end 
    @messages = Message.all
    @message = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    message = Message.new
    message.message = params[:message]
    message.sender_id = params[:sender_id]
    message.sender_model= params[:sender_model]
    message.receiver_id= params[:receiver_id]
    message.receiver_model= params[:receiver_model]
    message.save

    #Pusher.trigger("chat-1", "chat", {'username':'khaled'})
    respond_to do |format|
      if message.save
        puts 'aaa'
        format.html { redirect_to message, notice: 'Message was successfully posted.' }
        format.json { render :show, status: :created, location: @message }
      else
        puts "ssss"
        format.html { render :new }
        format.json { render json: message.errors, status: :unprocessable_entity }
      end
    end
  end
end  


        

