class Address < ActiveRecord::Base
  belongs_to :user
  has_one :user_attribute, :foreign_key => "primary_address_id"

  validates_presence_of :address_line_1, :city, :state, :postal_code, :mobile_number
  validates_length_of :postal_code, :maximum => 6, :minimum => 6
  validates_length_of :mobile_number, :maximum => 10, :minimum => 10
  validates_length_of :landline_number, :maximum => 11, :minimum => 11, :allow_blank => true
  validate :postal_code_is_number, :mobile_number_is_number

  def postal_code_is_number
    check_attribute_is_number(:postal_code)
  end

  def mobile_number_is_number
    check_attribute_is_number(:mobile_number)
  end

  def check_attribute_is_number(attribute_name)
    unless send(attribute_name) && send(attribute_name).is_positive_integer?
      errors.add(attribute_name, 'is not a number')
    end
  end
end
