# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
 # require 'recaptcha.rb'

      #before_action :check_captcha
  private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_in_params
        resource.validate # Look for any other validation errors besides Recaptcha
        set_minimum_password_length
        respond_with resource
      end 
    end
  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
        return '/students/edit'
    else
        return '/home'
    end
  end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
