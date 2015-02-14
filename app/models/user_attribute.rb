class UserAttribute < ActiveRecord::Base
  belongs_to :user

  def all_data_present?
    [:vat_number, :pan_number, :cst_number, :bank_name, :bank_branch, :bank_account_number, :bank_rtgs_code].all? do |attribute|
      send(attribute).present?
    end
  end

end
