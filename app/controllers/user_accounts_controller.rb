class UserAccountsController < ApplicationController
	def index
		@super = User.with_role(:super).pluck(:id)
		@users = User.where('id != ? AND id NOT IN (?)', current_user.id, @super)
	end

	def show
		
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				format.html { redirect_to user_accounts_path, notice: 'User was successfully created.' }
				format.json { render :show, status: :created, location: @user }
			else
				format.html { render :new }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	private
		def user_params
			params.require(:user).permit(
				:name, :email, :password, :password_confirmation, :user_type_id
			)
		end
end