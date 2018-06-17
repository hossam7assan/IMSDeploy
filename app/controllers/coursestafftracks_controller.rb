class CoursestafftracksController < InheritedResources::Base
  before_action :authenticate_admin_user!
  skip_before_action :verify_authenticity_token

  def beforenewpost
    session[:track]= params[:track_id]
    redirect_to :action => :new
  end

  def new
    @coursestafftrack = Coursestafftrack.new  
    @arrayofcourseids=[]
    @arrayofcoursenames=[]
    @courses = CoursesTrack.where(track_id: session[:track])
    for @course in @courses
      @tofindifitbelongstoadminuser = Staffcourse.where(course_id: @course.course_id)
      if @tofindifitbelongstoadminuser[0]["admin_user_id"] == current_admin_user.id
        @arrayofcourseids.push(@course.course_id)
        @name = Course.find(@course.course_id)
        @arrayofcoursenames.push(@name.name)
      end
    end
  end

  def index
    @arrayofcoursenames=[]
    @lecture_names=[]
    @lecture_ids=[]
    @lecture_links=[]
    @lecture_types=[]
    @lectureobject=[]
    @arrayofcourses = Staffcourse.where(admin_user_id: current_admin_user.id)
    for @arrayofcourse in @arrayofcourses
      @coursestafftracks = Coursestafftrack.where(course_id: @arrayofcourse.course_id)
      for @coursestafftrackk in @coursestafftracks
        @lecture_names.push(@coursestafftrackk.material_name)
        @lecture_links.push(@coursestafftrackk.material_url)
        @lecture_types.push(@coursestafftrackk.material_type)
        @lectureobject.push(@coursestafftrackk)
        @lecture_ids.push(@coursestafftrackk.id)
        @name = Course.find(@coursestafftrackk.course_id)
        @arrayofcoursenames.push(@name.name)
      end
    end
  end  
  def beforenew
    puts "okkkkkkkkkkkkkkk"
    @arrayofcourses = Staffcourse.where(admin_user_id: current_admin_user.id)
    puts current_admin_user.id
    @arrayoftracks=[]
    @arrayoftracksnames=[]
    for @arrayofcourse in @arrayofcourses
      @track = CoursesTrack.where(course_id: @arrayofcourse.course_id)
      @length = @arrayoftracks.length
      @arrayoftracks.push(@track[0]["track_id"]) unless @arrayoftracks.include?(@track[0]["track_id"])
        if @arrayoftracks.length == @length
        else
          @trackname = Track.find(@track[0]["track_id"])
          @arrayoftracksnames.push(@trackname.name) unless @arrayoftracksnames.include?(@trackname.name)
        end
    end
    if @arrayoftracksnames.blank?
      flash[:notice] = "There is no courses assigned to you yet"
      redirect_to posts_path
    end
  end 

  def edit
    @coursestafftrack = Coursestafftrack.find(params[:id])
    @arrayofcourseids=[]
    @arrayofcoursenames=[]
    @courses = CoursesTrack.where(track_id: session[:track])
    for @course in @courses
      @tofindifitbelongstoadminuser = Staffcourse.where(course_id: @course.course_id)
      if @tofindifitbelongstoadminuser[0]["admin_user_id"] == current_admin_user.id
        @arrayofcourseids.push(@course.course_id)
        @name = Course.find(@course.course_id)
        @arrayofcoursenames.push(@name.name)
      end
    end 
  end

  def create
    params[:coursestafftrack][:material_type] = params[:material_type]
    params[:coursestafftrack][:course_id] = params[:course_id]
    params[:coursestafftrack][:material_name] = params[:material_name]
    super
  end

  private
    def coursestafftrack_params
      params.require(:coursestafftrack).permit(:material, :course_id, :track_id, :admin_user_id, :material_name, :material_type)
    end
end

