FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "something@aaa.com"
    password "hkhkjhjkhjkhjkhjkhjkhkj"
    role :user
  end

  factory :unconfirmed_user, class: User do
    name "John Doe"
    email "something@aaa.com"
    password "hkhkjhjkhjkhjkhjkhjkhkj"
    role :user
    confirmation_token "sadadasdsssdasd"
    confirmation_sent_at Time.now
  end

  factory :confirmed_user, class: User do
    name "John Doe"
    email "something@aaa.com"
    password "hkhkjhjkhjkhjkhjkhjkhkj"
    role :user
    confirmed_at Time.now
    confirmation_sent_at Time.now
  end

  factory :approved_user, class: User do
    name "John Doe"
    email "something@aaa.com"
    password "hkhkjhjkhjkhjkhjkhjkhkj"
    role :user
    status :approved
    confirmed_at Time.now
    confirmation_sent_at Time.now
  end

  factory :admin, class: User do
    name "Admin User"
    role :admin
  end

  factory :user_attribute do
    user
    vat_number "sakdkasndkkjh"
    cst_number "sdasddsfinsdf"
    pan_number "dasnldnasjkdno"
    bank_name "asdnasndionaon"
    bank_branch "aosdasd"
    bank_account_number "asdn092qisdkfjns"
    bank_rtgs_code "asldnlasndlknas"
    station "sadasd"
  end

  factory :address do
    user
    address_line_1 "address_line_1"
    address_line_2 "address_line_2"
    city "city"
    state "state"
    postal_code "380009"
    mobile_number "9988776655"
    landline_number "89726578965"
  end
end