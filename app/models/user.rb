class User < ActiveRecord::Base
  enum role: [:user, :admin]
  enum status: [:pending, :approved]

  has_one :user_attribute, :dependent => :destroy, :autosave => true

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :set_default_values, :if => :new_record?

  def set_default_values
    self.role ||= :user
    self.status ||= :created
    self.user_attribute = UserAttribute.new
  end

  def all_data_updated?
    user_attribute.all_data_present?
  end

end
