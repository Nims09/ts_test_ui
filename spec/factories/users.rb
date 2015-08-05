# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(96)       default(""), not null
#  encrypted_password :string(60)       default(""), not null
#  created_at         :datetime
#  updated_at         :datetime
#

FactoryGirl.define do
	factory :user do
		email "user_#{User.last.nil? ? 1 : User.last.id + 1}@home.com"
		password "password"
	end
end
