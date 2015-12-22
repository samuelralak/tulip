class User < ActiveRecord::Base
	rolify

	belongs_to :user_type, inverse_of: :users
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	# :registerable, :recoverable
	devise :database_authenticatable, :rememberable, 
		:trackable, :validatable, :registerable
	validates :name, :user_type_id, presence: true

	after_save :assign_role

	private
		def assign_role
			if self.user_type_id
				user_type = UserType.find(self.user_type_id).code
			
				case user_type
					when "ADMINISTRATOR"
						self.add_role :admin
					when "STAFF"
						self.add_role :staff
					when "SUPER-USER"
						self.add_role :super
					else
						return
					end
			end
		end
end
