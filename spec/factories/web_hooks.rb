# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :web_hook do
    url "MyString"
    project_id 1
    type 1
    service_id 1
  end
end
