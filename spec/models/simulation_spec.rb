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

	context "validates" do
		it "has a valid factory" do 
			FactoryGirl.create(:simulation).should be_valid
		end

		it "is invalid without a x_size" do 
			FactoryGirl.build(:simulation, x_size: nil).should_not be_valid
		end

		it "is invalid without a y_size" do 
			FactoryGirl.build(:simulation, y_size: nil).should_not be_valid
		end

		it "is invalid with a x_size less than zero" do 
			FactoryGirl.build(:simulation, x_size: -1).should_not be_valid
		end
	
		it "is invalid with a x_size less than zero" do 
			FactoryGirl.build(:simulation, y_size: -1).should_not be_valid
		end
	end
end 

describe "build_arrangement" do
	before(:each) do
		@simulation = FactoryGirl.build(:simulation)
		@simulation.generate_arrangement
	end 

	context "creates the arrangement" do
		it "creates an arrangement" do 
			expect(@simulation.state.nil?).to be false
		end

		it "has the correct height" do 
			expect(@simulation.state.size).to be @simulation.y_size
		end 

		it "has the correct width" do
			expect(@simulation.state.first.size).to be @simulation.x_size
		end
	end

	context "creates a valid arrangement" do
		it "has only correct keys" do
			valid_keys = [:soft, :hard, :none]

			@simulation.state.each do |row|
				row.each do |opinion|
					expect(valid_keys.include? opinion).to be true
				end
			end
		end 
	end
end 