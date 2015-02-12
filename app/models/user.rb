class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  enum status: [:created, :ready, :approved]

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :set_default_values, :if => :new_record?

  def set_default_values
    self.role ||= :user
    self.status ||= :created
  end

end
