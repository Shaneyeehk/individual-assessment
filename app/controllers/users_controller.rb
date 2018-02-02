class UsersController < ApplicationController

	def create
		@user = User.check(params[:user][:email])
		if @user == nil
			@user = User.create(user_params)
			redirect_to root_path
		else
			render json: { error: 'Email exist' } # this part comes from aplication.js "response.error" will give me this message.
		end
	end

	def new
		@user = User.new
	end

	def sign_out
		session.clear
		redirect_to root_path
	end

	def sign_in
		current_user
		@user = User.find_by(email: params[:user][:email])
		if @user != nil && @user[:password] == @user.password
			session[:id] = @user.id
			redirect_to root_path, notice: 'Successfuly signed in'
		else
			render 'new', notice: 'Failed to sign in'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password)
		end

end
