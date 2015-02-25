class AdminUserAttribute < Upmin::Model
  attributes :id, :user_id, :vat_number, :cst_number, :pan_number, :bank_name, :bank_account_number, :bank_rtgs_code, :bank_branch

  items_per_page 15

end