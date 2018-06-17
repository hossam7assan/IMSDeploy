class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters,if: :devise_controller?
    def configure_permitted_parameters
      added_attrs = [:name, :email, :password, :password_confirmation, :birth, :gender, :avatar, :group_id ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
def authenticate_admin_user!
super
 raise SecurityError if current_admin_user.try(:Instructor)
end

    def current_ability
      @current_ability ||= Ability.new(current_student)
    end

    def render_404
      render file: "#{Rails.root}/public/404", status: :not_found
  end
  
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
      
  end
