require 'bcrypt'

class User < ActiveRecord::Base
	has_many :created_events, class_name: "Event", foreign_key: :creator_id
	has_many :event_attendances
	has_many :attended_events, through: :event_attendances, source: :event

	validates :email, presence: true, uniqueness: true, format: { with: /.*@.*[.].*/, message: "Please format your email address like 'sample@email.com'"}
	validates :password, presence: true
	validates :password_digest, presence: true

	include BCrypt

	def password
		@password ||= Password.new(password_digest)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_digest = @password
	end

end
