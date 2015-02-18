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
    @user.user_attribute.update_attributes(secure_user_attribute_params)
    redirect_to :edit_user_registration
  end

  private

  def secure_params
    params.require(:user).permit([:name,:role])
  end

  def secure_user_attribute_params
    params.require(:user_attribute).permit([:vat_number, :cst_number, :pan_number,
                  :bank_name, :bank_branch, :bank_account_number, :bank_rtgs_code, :cancelled_cheque_photo])
  end

end
