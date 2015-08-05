require 'spec_helper'

describe SimulationsController, :type => :controller do

	let :user do 
		FactoryGirl.create(:user)
	end

	before(:each) do
		@simulation = FactoryGirl.build(:simulation, user: user)
		@simulation.save!
		sign_in user	
	end

	describe "GET #index" do 

		it "should return response OK" do 
			get :index

			expect(response).to be_success
		end

		it "returns the correct number of simulations" do 
			get :index

			expect(assigns(:simulations)).to eq [@simulation]
		end
	end

	describe "GET #show" do

		it "should return response OK" do 
			get :show, id: @simulation.id

			expect(response).to be_success
		end 

		it "should return the correct record" do
			get :show, id: @simulation.id

			expect(assigns(:simulation)).to eq @simulation
		end

	end
end
