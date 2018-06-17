class CoursesTracksController < InheritedResources::Base

  private

    def courses_track_params
      params.require(:courses_track).permit()
    end
end

