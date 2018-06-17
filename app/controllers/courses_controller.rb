class CoursesController < InheritedResources::Base
  before_action :authenticate_admin_user!, only: [:new, :edit, :destroy, :allcourses] 
  before_action :authenticate_student!, only: [:show]
  before_action :get_course, only: [:show]
  def index
    @coursenames=[]
    @courseids=[]
    @track = ActiveRecord::Base.connection.exec_query("select track_id from lists where student_id=#{current_student.id}")
    @courses = CoursesTrack.where(track_id: @track[0]["track_id"])
    for @course in @courses
      @name = Course.where(id: @course.course_id)
      @coursenames.push("#{@name[0]['name']}")
      @courseids.push("#{@name[0]['id']}")
    end
  end

  def allcourses
    @coursenames=[]
    @courseobjects=[]
    @instructornames=[]
    @track = ActiveRecord::Base.connection.exec_query("select track_id from staffs where admin_user_id=#{current_admin_user.id}")
    @courses = CoursesTrack.where(track_id: @track[0]["track_id"])
    for @course in @courses
      @name = Course.where(id: @course.course_id)
      @coursenames.push("#{@name[0]['name']}")
      @courseobjects.push(@name[0])
      @instructorname = Staffcourse.where(course_id: @course.course_id)
      @instructorname = AdminUser.find(@instructorname[0]['admin_user_id'])
      @instructornames.push("#{@instructorname.name}")
    end
  end

  def show
    session[:student]=current_student
    @materials_material=[]
    @materials_material_name=[]
    @materials_material_type=[]
    @materials_material_id=[]
    @assignments_delivered=[]
    @assignmentfile=[]
    @assignments_createdat=[]
    @assignments_staff=[]
    @assignments_id=[]
    @assignments_review=[]
    @courseassignments_deadline=[]
    @courseassignments_description=[]
    @courseassignments_assignmentfile=[]
    @courseassignments_staff=[]
    @courseassignments_name=[]
    @courseassignments_id=[]
    materials = ActiveRecord::Base.connection.exec_query("select * from coursestafftracks where course_id=#{@course.id}")
    for material in materials
    @mat = Coursestafftrack.find(material['id'])
    # @materials_material.push("#{material['material']}")
    @materials_material.push(@mat.material_url)
    @materials_material_id.push("#{material['id']}")
    @materials_material_name.push("#{material['material_name']}")
    @materials_material_type.push("#{material['material_type']}")
    end
    assignmentsuploaded = ActiveRecord::Base.connection.exec_query("select * from assignmentstaffstudents where course_id=#{@course.id} and student_id=#{session[:student].id}")
    for assignmentuploaded in assignmentsuploaded
    @assignments_delivered.push("#{assignmentuploaded['derlivered_assignment']}")
    @assig = Assignmentstaffstudent.find(assignmentuploaded['id'])
    # @assignments_file.push("#{assignmentuploaded['file']}")
    @assignmentfile.push(@assig.file_url)
    @assignments_createdat.push("#{assignmentuploaded['created_at']}")
    @assignments_staff.push("#{assignmentuploaded['staff']}")
    @assignments_id.push("#{assignmentuploaded['id']}")
    @assignments_review.push("#{assignmentuploaded['codeReview']}")
    end
    courseassignments = ActiveRecord::Base.connection.exec_query("select * from assignments where course_id=#{@course.id}")
    for courseassignment in courseassignments
    @courseassignments_deadline.push("#{courseassignment['deadline']}")
    @courseassignments_description.push("#{courseassignment['description']}")
    # @courseassignments_assignmentfile.push("#{courseassignment['assignmentfile']}")
    @co = Assignment.find(courseassignment['id'])
    @courseassignments_assignmentfile.push(@co.assignmentfile_url)
    @courseassignments_staff.push("#{courseassignment['staff']}")
    @courseassignments_id.push("#{courseassignment['id']}")
    @courseassignments_name.push("#{courseassignment['name']}")
    end
  end
  def create
    course = Course.new
    course.name = params[:name] 
    existcourse = Course.where(name: course.name)
      if existcourse.empty?
        course.save!
        @trackid =  Staff.where(admin_user_id: current_admin_user.id)
        @instid = params[:admin_user_id]
        @list = CoursesTrack.new
        @list.course_id = course.id
        @list.track_id = @trackid[0]["track_id"]
        @list.created_at = course.created_at
        @list.updated_at = course.updated_at 
        @list.save!
        @coursestaff = Staffcourse.new
        @coursestaff.course_id = course.id
        @coursestaff.admin_user_id = @instid
        @coursestaff.created_at = course.created_at
        @coursestaff.updated_at = course.updated_at
        @coursestaff.save!
        # @list = ActiveRecord::Base.connection.exec_query("insert into courses_tracks (course_id, track_id, created_at, updated_at) values ('#{course.id}', #{@trackid[0]["track_id"]}, '#{course.created_at}', '#{course.updated_at}')")
        # @coursestaff = ActiveRecord::Base.connection.exec_query("insert into staffcourses (course_id, admin_user_id, created_at, updated_at) values ('#{course.id}', #{@instid}, '#{course.created_at}', '#{course.updated_at}')")
        redirect_to posts_path
      else
        flash[:notice] = "The course name must be unique"
        redirect_to posts_path
      end
  end
  # def destroy
  #   course = Course.find(params[:id])
  #   course.destroy!
  #   coursetrack = CoursesTrack.where(course_id: params[:id])
  #   coursetrack = CoursesTrack.find(coursetrack[0]["id"])
  #   coursetrack.destroy!
  #   staffcourse = Staffcourse.where(course_id: params[:id])
  #   staffcourse = Staffcourse.find(staffcourse[0]["id"])
  #   staffcourse.destroy!
  # end
  def new
    @course = Course.new
    @arrayofinstructornames=[]
    @arrayofinstructorids=[]
    @arrayofinstructors = ActiveRecord::Base.connection.exec_query("select * from admin_users where role='Instructor' ")
    if @arrayofinstructors.blank?
      flash[:notice] = "There is no instructors, add a new instructor first to assign it to the course"
      redirect_to posts_path
    else
      for @arrayodinstructor in @arrayofinstructors
        @arrayofinstructornames.push(@arrayodinstructor['name'])
        @arrayofinstructorids.push(@arrayodinstructor['id'])
      end
    end
  end
  
  def edit
    @course = Course.find(params[:id])
    session[:course] = params[:id]
    @arrayofinstructornames=[]
    @arrayofinstructorids=[]
    @instructorid = Staffcourse.where(course_id: params[:id])
    @instructorid = @instructorid[0]["admin_user_id"]
    @arrayofinstructors = ActiveRecord::Base.connection.exec_query("select * from admin_users where role='Instructor' ")
    for @arrayodinstructor in @arrayofinstructors
      @arrayofinstructornames.push(@arrayodinstructor['name'])
      @arrayofinstructorids.push(@arrayodinstructor['id'])
    end
  end
  def update
    course = Course.find(session[:course])
    course.name = params[:course][:name]
    course.save!
    existcoursefortheinstructor = Staffcourse.where(course_id: session[:course])
    updateinst = Staffcourse.find(existcoursefortheinstructor[0]["id"])
    updateinst.admin_user_id = params[:admin_user_id]
    updateinst.save! 
    redirect_to posts_path
  end

  private
    def course_params
      params.require(:course).permit(:name, track_attributes:[:track_id])
    end
    def get_course
      @course = Course.find(params[:id])
    end
  end

