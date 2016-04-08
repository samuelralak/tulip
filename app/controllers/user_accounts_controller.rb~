class UserAccountsController < ApplicationController
	before_action :check_user_permission
	before_action :set_user, only: [:show, :edit, :update, :destroy]

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

	def edit
		raise CanCan::AccessDenied if current_user.has_role?(:admin)
	end

	def update
	#	raise CanCan::AccessDenied if current_user.has_role?(:admin)

		respond_to do |format|
      		if @user.update(user_params)
        		format.html { redirect_to user_accounts_url, notice: 'user was successfully updated.' }
        		format.json { render :show, status: :ok, location: @user }
      		else
        		format.html { render :edit }
        		format.json { render json: @user.errors, status: :unprocessable_entity }
      		end
    	end
	end

	def destroy
		raise CanCan::AccessDenied if current_user.has_role?(:admin)
		
		@user.destroy
    	respond_to do |format|
      		format.html { redirect_to user_accounts_url, notice: 'User was successfully destroyed.' }
      		format.json { head :no_content }
    	end
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(
				:name, :email, :password, :password_confirmation, :user_type_id
			)
		end

		def check_user_permission
      		if current_user.has_role?(:staff || :administrator)
        		raise CanCan::AccessDenied
      		end
    	end
end
