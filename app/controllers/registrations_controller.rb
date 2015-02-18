class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    params[:password] ? resource.update_with_password(params) : resource.update_without_password(params)
  end

end
