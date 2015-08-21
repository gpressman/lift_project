class WeightsController < ApplicationController

	def index
		@user = User.find(params[:id])
		@user_weights = @user.weights.all
		@weights = Weight.all
	end

	def show
		@user = User.find(params[:id])
		@weight = @user.weights.find(params[:id])
	end

	def user_index
		@user = User.find(params[:id])
		@weights = @user.weight.all
	end
	
	def new
		@user = current_user
		@weights = Weight.all
		@weight = Weight.new
	end

	def create
		@user = current_user
		@weight_info = params.permit(:weight)
		@weight= Weight.new(weight_params)
		@weight.user_id = @user.id
        @user.current_weight = @weight
        if @weight.save
          redirect_to(user_weight_path(@user.id, @weight.id))
        else
           render 'new_user_weight'
        end
	end

	def weight_params
		params.require(:weight).permit(:weight)
	end
end
