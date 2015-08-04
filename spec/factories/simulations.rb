# == Schema Information
#
# Table name: simulations
#
#  id          :integer          not null, primary key
#  x_size      :integer
#  y_size      :integer
#  verdict     :string
#  arrangement :string
#  user_id     :integer
#

FactoryGirl.define do 
	factory :simulation do |f|
		f.id 1
		f.x_size 3
		f.y_size 3
		f.verdict "push"
		f.arrangement [
			["hard", "none", "none"],
			["none", "none", "none"],
			["none", "none", "soft"],
		]
		f.user_id 1
	end 
end 
