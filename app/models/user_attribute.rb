class UserAttribute < ActiveRecord::Base
  belongs_to :user

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

  def all_data_present?
    [:vat_number, :pan_number, :cst_number, :bank_name, :bank_branch, :bank_account_number, :bank_rtgs_code].all? do |attribute|
      send(attribute).present?
    end
  end

end
