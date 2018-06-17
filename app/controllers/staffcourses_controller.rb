class StaffcoursesController < InheritedResources::Base

  private

    def staffcourse_params
      params.require(:staffcourse).permit()
    end
end

