class CoursestudenttracksController < InheritedResources::Base
  before_action :authenticate_admin_user!, only: [:index, :new]
  before_action :authenticate_student!, only: [:show]
  skip_before_action :verify_authenticity_token

  def new  
    @coursestudenttrack = Coursestudenttrack.new  
    @coursenames=[]
    @courseids=[]
    @studentnames=[]
    @studentids=[]
    @trackid =  Staff.where(admin_user_id: current_admin_user.id)
    @courses = ActiveRecord::Base.connection.exec_query("select * from courses_tracks where track_id=#{@trackid[0]["track_id"]}")
    for @course in @courses
      @tempcourse = Course.find(@course['course_id'])
      @coursenames.push("#{@tempcourse.name}")
      @courseids.push("#{@tempcourse.id}")
    end  
    @students = ActiveRecord::Base.connection.exec_query("select student_id from lists where track_id=#{@trackid[0]["track_id"]}")
    for @student in @students
      @tempstudent = Student.find(@student["student_id"])
      @studentnames.push("#{@tempstudent.name}")
      @studentids.push("#{@student["student_id"]}")
    end
    if @students.blank?
      flash[:notice] = "There is no students yet you can't enter a grade"
      redirect_to posts_path
    else
      if @courses.blank?
        flash[:notice] = "There is no courses yet you can't enter a grade"
        redirect_to posts_path
      end
    end
  end 
  def show
    session[:student]=current_student
    @coursename=[]; 
    @coursestudenttracks = ActiveRecord::Base.connection.exec_query("select * from coursestudenttracks where student_id=#{session[:student].id}")
    for coursestudenttrack in @coursestudenttracks
      # result = ActiveRecord::Base.connection.exec_query("select * from courses where id=#{coursestudenttrack['course_id']}")
      result = Course.find(coursestudenttrack['course_id'])
      # @coursename.push(result[0]['name'])
      @coursename.push(result.name)
    end
  end
  def edit
    @trackid =  Staff.where(admin_user_id: current_admin_user.id)
    @student = Student.find(params[:id])
    @coursenames=[]
    @courses = ActiveRecord::Base.connection.exec_query("select * from courses_tracks where track_id=#{@trackid[0]["track_id"]}")
    for @course in @courses
      @tempcourse = Course.find(@course['course_id'])
      @coursenames.push("#{@tempcourse.name}")
    end
      @gradesarray=[]
      flag = 0
      for @course in @courses  
        # @grades = ActiveRecord::Base.connection.exec_query("select grade from coursestudenttracks where track_id=#{@trackid[0]["track_id"]} and student_id=#{@student.id} and course_id=#{@course['course_id']}")
        @grades = Coursestudenttrack.where(track_id: @trackid[0]["track_id"], student_id: @student.id, course_id: @course['course_id'])
        if(@grades.blank?)
          @gradesarray.push("empty")
        else
          @grades = Coursestudenttrack.find(@grades[0]["id"])
          if (@grades.blank?)
            @gradesarray.push("empty")
          else
            @grades = @grades.grade
            flag = 1
            # @gradesarray.push(@grades[0]["grade"])
            @gradesarray.push(@grades)
          end
        end
      end
      if flag ==0
        flash[:notice] = "You haven't entered a grade for this student before"
        redirect_to :action => :index
      end
  end
  def update
    @trackid =  Staff.where(admin_user_id: current_admin_user.id)
    @counter=0
    @courses = ActiveRecord::Base.connection.exec_query("select * from courses_tracks where track_id=#{@trackid[0]["track_id"]}")
    for @course in @courses
      # @grades = ActiveRecord::Base.connection.exec_query("select * from coursestudenttracks where track_id=#{@trackid[0]["track_id"]} and student_id=#{params[:student]} and course_id=#{@course['course_id']}")
      @grades = Coursestudenttrack.where(track_id: @trackid[0]["track_id"], student_id: params[:student], course_id: @course['course_id'])
      @grades = Coursestudenttrack.find(@grades[0]["id"])
      if(params[:grade]["#{@counter}"]=="empty")
      else
        # @desiredrecord = Coursestudenttrack.find(@grades[0]["id"])
        @desiredrecord = Coursestudenttrack.find(@grades.id)
        @desiredrecord.grade = params[:grade]["#{@counter}"]
        @desiredrecord.save!
      end
      @counter = @counter +1
    end
    redirect_to :action => :index
  end
  def index
    @coursestudenttrackk = Coursestudenttrack.all
    @trackid =  Staff.where(admin_user_id: current_admin_user.id)
    @arrayfordrawingchart=[]
    @coursenames=[]
    @studentnames=[]
    @studentids=[]
    @gradesforeachstudent=[]
    @courses = ActiveRecord::Base.connection.exec_query("select * from courses_tracks where track_id=#{@trackid[0]["track_id"]}")
    for @course in @courses
      @tempcourse = Course.find(@course['course_id'])
      @coursenames.push("#{@tempcourse.name}")
    end
    @students = ActiveRecord::Base.connection.exec_query("select student_id from lists where track_id=#{@trackid[0]["track_id"]}")
    for @student in @students
      @tempstudent = Student.find(@student["student_id"])
      @studentnames.push("#{@tempstudent.name}")
      @studentids.push("#{@student["student_id"]}")
      @gradesarray=[]
      @gradesum = 0
      for @course in @courses  
        @grades = Coursestudenttrack.where(track_id: @trackid[0]["track_id"], student_id: @student['student_id'], course_id: @course['course_id'])
        # @grades = ActiveRecord::Base.connection.exec_query("select grade from coursestudenttracks where track_id=#{@trackid[0]["track_id"]} and student_id=#{@student['student_id']} and course_id=#{@course['course_id']}")
        if (@grades.blank?)
          @gradesarray.push(0)
          @gradesum = @gradesum + 0
        else
          @grades = @grades[0]["grade"]
          @gradesarray.push(@grades)
          @gradesum = @gradesum + @grades
        end
      end
      @arrayfordrawingchart.push([@tempstudent.name, @gradesum])
      @gradesforeachstudent.push(@gradesarray)
    end

  end
  def create 
    begin
      # @track = ActiveRecord::Base.connection.exec_query("select track_id from lists where student_id=#{params[:student_id]}")
      @track = List.where(student_id: params[:student_id])
      @track = List.find(@track[0]["id"])
      @track = @track.track_id
      coursestudenttrack = Coursestudenttrack.new
      coursestudenttrack.grade = params[:grade]
      coursestudenttrack.course_id = params[:course_id]
      # coursestudenttrack.track_id = @track[0]["track_id"]
      coursestudenttrack.track_id = @track
      coursestudenttrack.student_id = params[:student_id]
      # existcourse = Coursestudenttrack.where(track_id: @track[0]["track_id"], student_id: coursestudenttrack.student_id, course_id: params[:course_id])
      existcourse = Coursestudenttrack.where(track_id: @track, student_id: coursestudenttrack.student_id, course_id: params[:course_id])
      if existcourse.empty?
        coursestudenttrack.save!
        redirect_to :action => :index
      else
        flash[:notice] = "You have entered a grade for this student before, you can edit it now"
        redirect_to :action => :index
      end
    end
  end
  

  private

    def coursestudenttrack_params
      params.require(:coursestudenttrack).permit(:grade, :course_id, :track_id, :student_id)
    end
end

