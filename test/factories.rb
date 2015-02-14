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
    factory :approved_user_with_attributes do
      after(:create) do |user, evaluator|
        create(:user_attribute, user: user)
      end
    end
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
end