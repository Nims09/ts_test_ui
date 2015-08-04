require 'spec_helper'

describe SimulationsController, :type => :controller do 
	context "GET #index" do 
		it "populates an array of simulations" do 
			simulation = FactoryGirl.build(:simulation)
			get :index
			response.should render_template :index
		end 

		# it "populates an array of the current users simulations"
		# it "renders the :index view"
	end

	context "GET #show" do
		# it "assigns the requested contact to @contact" do 

		# end
	end	
end
