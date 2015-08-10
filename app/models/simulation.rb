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

class Simulation < ActiveRecord::Base
	belongs_to :user

	serialize :arrangement, Array
	serialize :opinion, Hash 

	validates :user_id, :identifier, presence: true
	validates :x_size, :y_size, presence: true, :numericality => {:only_integer => true}
	validates_numericality_of :x_size, :y_size, :greater_than => 0

	def self.keys
		[:soft, :hard, :none]
	end 

	def rand_opinion
		Simulation.keys[rand(0..2)]
	end

	def generate_arrangement
		arrangement = Array.new(y_size) { Array.new(x_size) } 
		opinion = Hash[ Simulation.keys.map { |key| [key, 0] } ]

		arrangement.each_with_index do |row, y_index|
			row.each_with_index do |current, x_index|
				generated_opinion = rand_opinion
				arrangement[y_index][x_index] = generated_opinion
				opinion[generated_opinion] += 1
			end
		end

		self.opinion = opinion
		self.arrangement = arrangement
 	end

	def verdict
		if opinion[:hard] > opinion[:soft]
		  :hard
		elsif opinion[:soft] > opinion[:hard]
		  :soft
		else
		  :push
		end
	end	

	def state 
		self.arrangement
	end

	def next
		new_arrangement = Array.new(arrangement.size) { |array| array = Array.new(arrangement.first.size) }
		opinion = Hash[ Simulation.keys.map { |key| [key, 0] } ]

		self.arrangement.each_with_index do |array, y_index|
			array.each_with_index do |opinion_current, x_index|
				new_arrangement[y_index][x_index] = update_opinion_for x_index, y_index
				opinion[new_arrangement[y_index][x_index]] += 1
			end
		end

		self.opinion = opinion
		self.arrangement = new_arrangement
	end

	private 

	def in_array_range?(x, y)
		((x >= 0) and (y >= 0) and (x < arrangement[0].size) and (y < arrangement.size))
	end

	def update_opinion_for(x, y)
		local_opinions = Hash[ Simulation.keys.map { |key| [key, 0] } ]

		for y_pos in (y-1)..(y+1)
			for x_pos in (x-1)..(x+1)
				if in_array_range? x_pos, y_pos and not(x == x_pos and y == y_pos)
					local_opinions[arrangement[y_pos][x_pos]] += 1
				end
			end
		end

		opinion_current = arrangement[y][x]
		opinionated_neighbours_count = local_opinions[:hard] + local_opinions[:soft]

		if (opinion_current != :none) and (opinionated_neighbours_count < 2 or opinionated_neighbours_count > 3)
			opinion_current = :none    
		elsif opinion == :none and opinionated_neighbours_count == 3
			if local_opinions[:hard] > local_opinions[:soft]
				opinion_current = :hard
			elsif local_opinions[:soft] > local_opinions[:hard]
				opinion_current = :soft
			end 
		end 

		opinion_current
	end

end
