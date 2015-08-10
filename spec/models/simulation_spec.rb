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

require 'spec_helper'

describe Simulation do 

	context "validates" do
		it "has a valid factory" do 
			expect(FactoryGirl.create(:simulation)).to be_valid
		end

		it "is invalid without a x_size" do 
			expect(FactoryGirl.build(:simulation, x_size: nil)).not_to be_valid
		end

		it "is invalid without a y_size" do 
			expect(FactoryGirl.build(:simulation, y_size: nil)).not_to be_valid
		end

		it "is invalid without an user_id" do 
			expect(FactoryGirl.build(:simulation, user_id: nil)).not_to be_valid
		end		

		it "is invalid without an identifier" do 
			expect(FactoryGirl.build(:simulation, identifier: nil)).not_to be_valid
		end

		it "is invalid with a x_size less than zero" do 
			expect(FactoryGirl.build(:simulation, x_size: -1)).not_to be_valid
		end
	
		it "is invalid with a x_size less than zero" do 
			expect(FactoryGirl.build(:simulation, y_size: -1)).not_to be_valid
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

	context "simulation.opinions" do 

		before(:each) do
			@simulation.generate_arrangement
		end

		it "fills opinions hash" do
			expect(@simulation.opinion.nil?).to be false
		end

		it "collects the correct values" do
			counts = Hash[ Simulation.keys.map { |key| [key, 0] } ]

			@simulation.state.each do |row|
				row.each do |item|
					counts[item] += 1
				end
			end

			counts.each do |count, value|
				expect(value).to eq @simulation.opinion[count]
			end
		end
	end

	context "returns a verdict" do 

		before(:each) do
			@simulation.generate_arrangement			
		end

		it "returns a verdict within the key range" do 
			expect([:hard, :soft, :push].include?(@simulation.verdict)).to be true
		end

		it "updates the verdict after a next call" do
			@simulation.next
			
			counts = Hash[ Simulation.keys.map { |key| [key, 0] } ]

			@simulation.state.each do |row|
				row.each do |item|
					counts[item] += 1
				end
			end

			counts.each do |count, value|
				expect(value).to eq @simulation.opinion[count]
			end
		end		
	end
end 
