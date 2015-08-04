# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(96)       default(""), not null
#  encrypted_password :string(60)       default(""), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  
	has_many :simulations

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :validatable

	# Validations
	# :email
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
