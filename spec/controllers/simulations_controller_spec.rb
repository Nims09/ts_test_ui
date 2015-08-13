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

		before(:each) do
			get :index			
		end

		it "should return response OK" do 
			expect(response).to be_success
		end

		it "returns the correct number of simulations" do 
			expect(assigns(:simulations)).to eq [@simulation]
		end
	end

	describe "GET #show" do

		before(:each) do
			get :show, id: @simulation.id			
		end		

		it "should return response OK" do 
			expect(response).to be_success
		end 

		it "should return the correct record" do
			expect(assigns(:simulation)).to eq @simulation
		end
	end

	describe "GET #new" do

		before(:each) do
			get :new			
		end

		it "assigns a new simulation to @simulation" do
			expect(assigns(:simulation)).to be_a_new(Simulation)
		end

		it "assigns a new simulation to the current logged in user" do 
			expect(assigns(:simulation).user_id).to eq user.id
		end
	end

	describe "POST #create" do 

		before(:each) do
			@simulation_params = FactoryGirl.attributes_for(:simulation)
		end

		it "creates a simulation" do 
			expect { post :create, :simulation => @simulation_params }.to change(Simulation, :count).by(1)
		end

		it "should give the simulation state" do 
			post :create, :simulation => @simulation_params

			expect(Simulation.last.state.nil?).to be false
		end
	end

	describe "DELETE #destroy" do 

		it "should redirect" do
			delete :destroy, :id => @simulation.id

			expect(response.status).to eq 302
		end

		it "should delete the simulation" do
			expect { delete :destroy, :id => @simulation.id }.to change(Simulation, :count).by(-1)
		end
	end

	describe "PUT #update" do 
		
		it "should call simulation#next" do
			expect_any_instance_of(Simulation).to receive(:next)

			put :update, :id => @simulation.id, :format => 'js'
		end

		it "should render a partial when the record is dirty" do 
			allow_any_instance_of(Simulation).to receive(:dirty?).and_return(true)

			put :update, :id => @simulation.id, :format => 'js'

			expect(response).to render_template( :partial => '_show' )
		end

		it "should not render a partial if the record is not dirty" do 
			allow_any_instance_of(Simulation).to receive(:dirty?).and_return(false)

			put :update, :id => @simulation.id, :format => 'js'

			expect(response).not_to render_template( :partial => '_show' )
		end
	end
end
