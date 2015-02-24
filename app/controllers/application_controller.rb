class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :check_user_status

  before_filter -> { flash.now[:alert] = flash[:alert].html_safe if flash[:html_safe] && flash[:alert] }
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  protected

  def check_user_status
    if current_user && current_user.user?
      if !current_user.all_data_updated? && request.path != edit_user_registration_path
        if user_controller?
          request.flash[:alert] ||= %Q[You need to fill necessary details in your profile #{view_context.link_to("here",edit_user_registration_url)}]
          flash[:html_safe] = true
        else
          redirect_to :edit_user_registration, :alert => "You need fill these mandatory fields about your company before continuing"
        end
      end
      if current_user.all_data_updated? && current_user.pending?
        request.flash[:alert] ||= %Q[Your account status is pending. It will be approved once our administrator verifies the details uploaded by you.] unless user_controller?
      end
    end
  end

  def user_controller?
    is_a?(::DeviseController) || is_a?(Upmin::ApplicationController) || is_a?(UsersController) || is_a?(VisitorsController)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :role)
  end
end
