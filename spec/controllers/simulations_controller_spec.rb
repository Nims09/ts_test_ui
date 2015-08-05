require 'spec_helper'

describe SimulationsController, :type => :controller do

	let :user do 
		FactoryGirl.create(:user)
	end

	before(:each) do 
					puts user.email

		sign_in user	
	end

	describe "GET #index" do 
		it "populates an array of simulations" do 
			simulation = FactoryGirl.build(:simulation, user_id: user.id)
			get :index
			expect(response).to be_success
			puts user.email
		end

		it "returns the correct number of simulations" do 
			simulation = FactoryGirl.build(:simulation, user_id: user.id)
			get :index
			puts assigns(:simulations)
			# expect(response).to be_success			
		end

		# it "populates an array of the current users simulations"
		# it "renders the :index view"
	end

	# context "GET #show" do
	# 	# it "assigns the requested contact to @contact" do 

	# 	# end
	# end	
end
