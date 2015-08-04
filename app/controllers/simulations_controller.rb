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
		@simulation.generate_arrangement

		@simulation.save
		redirect_to @simulation
	end

	def show
		@simulation = Simulation.find(params[:id])
	end

	def update
	# This can be used for updating the next state transition.
	# This action should be asynchronous
	end

	def destroy
	# This action should be asynchronous.
	end

	private

	def simulation_params
		params.require(:simulation).permit(:x_size, :y_size)
	end

end