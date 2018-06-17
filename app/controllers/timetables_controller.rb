class TimetablesController < InheritedResources::Base
  before_action :authenticate_admin_user!, only: [:new]
  before_action :authenticate_student!, only: [:index]
  def new 
    @trackid =  Staff.where(admin_user_id: current_admin_user.id)
    session[:track] = @trackid[0]["track_id"]
    @timetable =  Timetable.new
  end
  def create
    @timetable = Timetable.where(track_id: session[:track])
    if @timetable.empty?
      @timetable = Timetable.new
      @timetable.timetable_link = params[:timetable][:timetable_link]
      @timetable.track_id = session[:track]
      @timetable.save!
    else
      updatetimetable = Timetable.find(@timetable[0]["id"])
      updatetimetable.timetable_link = params[:timetable][:timetable_link]
      updatetimetable.save! 
      puts updatetimetable
    end
    redirect_to posts_path
  end
  def index
    @trackid =  List.where(student_id: current_student.id)
    @timetable = Timetable.where(track_id: @trackid[0]["track_id"])
    if @timetable.empty?
      @timetable="empty"
    else
    @timetable = Timetable.find(@timetable[0]["id"])  
    end
  end

  private

    def timetable_params
      params.require(:timetable).permit(:track_id, :timetable_link)
    end
end

