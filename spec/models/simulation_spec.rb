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
require 'spec_helper'

describe Simulation do 

	it "has a valid factory" do 
		FactoryGirl.create(:simulation).should be_valid
	end

	it "is invalid without a x_size" do 
		FactoryGirl.build(:simulation, x_size: nil).should_not be_valid
	end

	it "is invalid without a y_size" do 
		FactoryGirl.build(:simulation, y_size: nil).should_not be_valid
	end

	it "is invalid without a verdict" do 
		FactoryGirl.build(:simulation, verdict: nil).should_not be_valid
	end

	it "is invalid without a arrangement" do 
		FactoryGirl.build(:simulation, arrangement: nil).should_not be_valid
	end
end 
