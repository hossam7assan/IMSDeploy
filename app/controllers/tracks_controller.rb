class TracksController < InheritedResources::Base

  private

    def track_params
      params.require(:track).permit(:name, :intake, :type)
    end
end

