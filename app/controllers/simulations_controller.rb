class SimulationsController < ApplicationController

	def index
		if current_user 
			@simulations = current_user.simulations
		else 
			redirect_to new_user_session_path, notice: 'You are not logged in.'
		end
	end

	def new
		@simulation = current_user.simulations.build
	end

	def create
		@simulation = Simulation.new(simulation_params)
		@simulation.user_id = current_user.id
		@simulation.generate_arrangement

		if @simulation.save
			redirect_to @simulation
		else
			setup_simulations
			render :index
		end
	end

	def show
		@simulation = Simulation.find(params[:id])	
	end

	def update
		@simulation = Simulation.find(params[:id])
		@simulation.next

		if (@simulation.save && @simulation.dirty?)
			render :partial => 'show', :object => @simulation
		end
	end
	
	def destroy
		@simulation = Simulation.find(params[:id])
		@simulation.destroy

		respond_to do |format|
			format.js
			format.html { redirect_to simulations_url  }
		end		
	end

	private

	def simulation_params
		params.require(:simulation).permit(:x_size, :y_size, :identifier)
	end

end