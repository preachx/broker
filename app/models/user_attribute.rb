class UserAttribute < ActiveRecord::Base
  belongs_to :user
  belongs_to :primary_address, class_name: "Address", foreign_key: "primary_address_id", primary_key: "id"

  after_update :change_user_status

  has_attached_file :cancelled_cheque_photo,
                    :styles => { :original => "600x600>", :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png",
                    :url  => "/system/:class/:attachment/:id_partition/:style/:normalize_basename.:extension",
                    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:normalize_basename.:extension"

  validates_attachment_content_type :cancelled_cheque_photo, :content_type => /\Aimage\/.*\Z/

  Paperclip.interpolates :normalize_basename do |attachment, style|
    attachment.instance.normalize_basename
  end


  def normalize_basename
    "#{user.id}_#{id}_cheque"
  end

  def change_user_status
    if all_data_present? && user.pending?
      self.user.awaiting_approval!
    end
  end

  def all_data_present?
    [:vat_number, :pan_number, :cst_number, :bank_name, :bank_branch, :bank_account_number, :bank_rtgs_code, :primary_address].all? do |attribute|
      send(attribute).present?
    end && cancelled_cheque_photo.exists?
  end

  def set_primary_address(address)
    self.primary_address = address
    self.save!
  end

end
