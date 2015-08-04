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
		f.id (Simulation.last.nil? ? 1 : Simulation.last.id + 1)
		f.x_size 3
		f.y_size 3
		f.user_id 1
	end 
end 
