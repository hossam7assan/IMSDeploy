class AssignmentstaffstudentsController < InheritedResources::Base
  before_action :authenticate_admin_user!, only: [:index]
  before_action :authenticate_student!, only: [:new]
  skip_before_action :verify_authenticity_token

  def index
    @assignmentstaffstudents = []
    @arrayofcourses = Staffcourse.where(admin_user_id: current_admin_user.id)
    for @arrayofcourse in @arrayofcourses
    @assignmentstaffstudent = Assignmentstaffstudent.where(course_id: @arrayofcourse.course_id)
    for @assignmentstaffstudentt in @assignmentstaffstudent
    @assignmentstaffstudents.push(@assignmentstaffstudentt)
    end
    end
    @trackarray=[]
    @assignmentstaffstudents.each_with_index do |assignmentss, index| 
      puts @assignmentstaffstudents[index]["course_id"]
      @coursestracks = CoursesTrack.where(course_id: @assignmentstaffstudents[index]["course_id"])
      @trackname = Track.where(id: @coursestracks[0]["track_id"])
      @trackarray.push(@trackname[0]["name"])
    end
  end

  def new  
    session[:student]=current_student
    @assignments = Assignment.find(params[:id])
    @assignmentstaffstudent = Assignmentstaffstudent.new  
    @studentid = session[:student].id  
    @staffid = @assignments.admin_user_id
    @assignmentid = @assignments.id
    @groupid = session[:student].group_id
    @courseid= @assignments.course_id
  end 
  def show 
    @assignmentstaffstudent = Assignmentstaffstudent.find(params[:id])
  end 
  def submitcodereview
    @assignments = Assignmentstaffstudent.find(params[:id])
    @assignments.codeReview = params[:codeReview]
    @assignments.save!
    redirect_to :action => :index
  end
  def create 
    params[:assignmentstaffstudent][:derlivered_assignment] = params[:derlivered_assignment]
    super
  end
  private
    def assignmentstaffstudent_params   
    params.require(:assignmentstaffstudent).permit(:derlivered_assignment, :assignment_id, :student_id, :admin_user_id, :file, :course_id, :codeReview)
    end
end

