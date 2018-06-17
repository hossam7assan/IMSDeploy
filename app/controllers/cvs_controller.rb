class CvsController < InheritedResources::Base
  before_action :authenticate_admin_user!, only: [:index]
  before_action :authenticate_student!, only: [:new, :edit]

  def company
    cvs = []
    @cvs = Cv.all
   
  end

  def show
    @cvarray=[]
    @adminarray=[]


    @cv_comments = Cv.where(student_id: current_student.id).take
    # puts @cv_comments.id
    @cvs_comments = ActiveRecord::Base.connection.exec_query("select * from active_admin_comments where resource_id =#{@cv_comments.id} and resource_type='Cv'")   

    for @cv_comment in @cvs_comments 
    @cvarray.push( @cv_comment["body"])
    @adminarray.push(@cv_comment["author_id"])
    end
    @cv = Cv.find(params[:id])
  end
  
  def index
    @students_arr = []
    @students = Cv.all
    for @student in @students
    @students_arr.push( @student["student_id"])
    end
    @cvs = Cv.all
  end

  def create
    if Cv.exists?(student_id: current_student.id)
      @cv = Cv.all
      @cvdata = Cv.new(cv_params)
      @file_name = @cvdata.path.file.filename
      @cv = Cv
    @update_cv = Cv.where(student_id: current_student.id).limit(1).update_all(path: @file_name)
    redirect_to :controller => 'cvs', :action => 'index'

  else
      @cv = Cv.new(cv_params)
    respond_to do |format|
      if @cv.save
        format.html { redirect_to @cv, notice: 'Cv was successfully created.' }
        format.json { render :show, status: :created, location: @cv }
      else
        format.html { render :new }
        format.json { render json: @cv.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  private

    def cv_params
      params.require(:cv).permit(:path, :student_id)
    end
end

