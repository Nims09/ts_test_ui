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

	validates :x_size, :y_size, :verdict, :arrangement, presence: true
end
