class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def update_attributes
    @user = User.find(params[:id])
    authorize @user
    attributes_updated = @user.user_attribute.update_attributes(secure_user_attribute_params)
    if attributes_updated
      redirect_to :edit_user_registration, :notice => "Attributes were updated successfully"
    else
      redirect_to :edit_user_registration, :alert => error_messages_for(@user.user_attribute)
    end
  end

  private

  def error_messages_for(model)
    return '' if model.errors.empty?

    messages = model.errors.full_messages.map { |msg| "<li> #{msg} </li>" }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: model.errors.count,
                      resource: model.class.model_name.human.downcase)

    html = <<-HTML
      <h3>#{sentence}</h3>
    <ul>#{messages}</ul>
    HTML

    html.html_safe
  end

  def secure_params
    params.require(:user).permit([:name,:role])
  end

  def secure_user_attribute_params
    params.require(:user_attribute).permit([:vat_number, :cst_number, :pan_number,
                  :bank_name, :bank_branch, :bank_account_number, :bank_rtgs_code, :cancelled_cheque_photo])
  end

end
