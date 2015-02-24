class AdminUser < Upmin::Model
  attributes :id, :email, :name, :role, :status, :created_at

  items_per_page 15

  action :confirm!
  action :approve!
  action :reset_password!

  def approve!
    model.update_attribute(:status, "approved") if can_approve?
  end


end