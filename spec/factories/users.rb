FactoryGirl.define do
	factory :user do
		email "user_#{User.last.nil? ? 1 : User.last.id + 1}@home.com"
		password "password"
	end
end