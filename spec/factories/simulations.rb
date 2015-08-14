# == Schema Information
#
# Table name: simulations
#
#  id          :integer          not null, primary key
#  x_size      :integer
#  y_size      :integer
#  arrangement :string
#  user_id     :integer
#  opinion     :string
#  identifier  :string
#

FactoryGirl.define do 
	factory :simulation do |f|
		f.x_size 3
		f.y_size 3
		f.user_id 1
		f.identifier "testIdent"
	end 
end 
