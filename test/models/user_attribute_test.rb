require 'test_helper'

class UserAttributeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  should "check all data present" do
    user = FactoryGirl.create(:approved_user_with_attributes)
    assert user.user_attribute.all_data_present?
  end
end
