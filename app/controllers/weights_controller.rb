class WeightsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@user_weights = @user.weights.all
		@weights = Weight.all
	end

	def show
		@user = User.find(params[:id])
		@weight = @user.weights.find(params[:id])
	end

	def user_index
		@user = User.find(params[:id])
		
	end
	
	def new
		@user = current_user
		@weights = Weight.all
		@weight = Weight.new
	end

	def create
		@user = User.find(params[:user_id])
		@weight= @user.weights.new(weight_params)
        @user.current_weight = @weight.weight
        @user.save
        if @weight.save
          redirect_to(user_weights_path(@user.id))
        else
           render 'new_user_weight'
        end
	end

	private

	def weight_params
		params.require(:weight).permit(:weight)
	end
end




