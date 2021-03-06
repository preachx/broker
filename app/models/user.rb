class User < ActiveRecord::Base
  enum role: [:user, :admin]
  enum status: [:pending, :awaiting_approval, :approved]

  has_one :user_attribute, :autosave => true
  has_many :addresses

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :set_default_values

  def set_default_values
    self.role = :user if role.blank?
    self.status = :pending if status.blank?
    self.user_attribute = UserAttribute.new if user_attribute.blank?
  end

  def all_data_updated?
    user_attribute.all_data_present?
  end


  def can_approve?
    confirmed? && awaiting_approval?
  end

end
