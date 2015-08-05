FactoryGirl.define do
	factory :account do
		email "fake@fake.com"
		password "password"
		password_confirmation "password"
		confirmed_at Date.today
	end
end