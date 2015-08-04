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

class Simulation < ActiveRecord::Base
	belongs_to :user

	serialize :arrangement, Array

	validates :x_size, :y_size, presence: true
	validates_numericality_of :x_size, :y_size, :greater_than => 0

	def self.keys
		[:soft, :hard, :none]
	end 

	def generate_arrangement
		@opinions = Hash[ Simulation.keys.map { |key| [key, 0] } ]
		@arrangement = Array.new(y_size) { Array.new(x_size) }

		@arrangement.each_with_index do |row, y_index|
			row.each_with_index do |current, x_index|
				rand_opinion = Simulation.keys[rand(0..2)]
				@arrangement[y_index][x_index] = rand_opinion
				@opinions[rand_opinion] += 1
			end
		end
	end

	def verdict
		if @opinions[:hard] > @opinions[:soft]
		  :hard
		elsif @opinions[:soft] > @opinions[:hard]
		  :soft
		else
		  :push
		end
	end	

	def state 
		@arrangement
	end

	def next
		new_arrangement = Array.new(@arrangement.size) { |array| array = Array.new(@arrangement.first.size) }
		@opinions = Hash[ Simulation.keys.map { |key| [key, 0] } ]

		@seating_arrangement.each_with_index do |array, y_index|
			array.each_with_index do |opinion, x_index|
				new_arrangement[y_index][x_index] = update_opinion_for x_index, y_index
				@opinions[new_arrangement[y_index][x_index]] += 1
			end
		end

		@arrangement = new_arrangement
	end

	private 

	def in_array_range?(x, y)
		((x >= 0) and (y >= 0) and (x < @arrangement[0].size) and (y < @arrangement.size))
	end

	def update_opinion_for(x, y)
		local_opinions = Hash[ Simulation.keys.map { |key| [key, 0] } ]

		for y_pos in (y-1)..(y+1)
			for x_pos in (x-1)..(x+1)
				if in_array_range? x_pos, y_pos and not(x == x_pos and y == y_pos)
					local_opinions[@arrangement[y_pos][x_pos]] += 1
				end
			end
		end

		opinion = @arrangement[y][x]
		opinionated_neighbours_count = local_opinions[:hard] + local_opinions[:soft]

		if (opinion != :none) and (opinionated_neighbours_count < 2 or opinionated_neighbours_count > 3)
			opinion = :none    
		elsif opinion == :none and opinionated_neighbours_count == 3
			if local_opinions[:hard] > local_opinions[:soft]
				opinion = :hard
			elsif local_opinions[:soft] > local_opinions[:hard]
				opinion = :soft
			end 
		end 

		opinion
	end

end
