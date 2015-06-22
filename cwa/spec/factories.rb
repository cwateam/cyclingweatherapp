FactoryGirl.define do
  factory :user do
    username "Veera"
    password "salasana1"
    password_confirmation "salasana1"
  end

  factory :device do
    device_id "laite"
    device_profile_id 1
    user_id 1
  end

  factory :device_profile do
    profile_name "abcd"
    sw_version "efg"
    hw_version "123"
    device_type "qwerty"
    data_transformer "bob"
    name "yesyes"
    info "info here"
  end
end