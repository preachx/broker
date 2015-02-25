require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should "create a new address" do
    assert FactoryGirl.create(:address)
  end
end
