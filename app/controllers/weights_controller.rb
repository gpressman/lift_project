class WeightsController < ApplicationController

	def index
		@user = current_user
		@user_weights = @user.weights.all
		@weights = Weight.all
	end

	def user_index
		@user = current_user
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
		@weight= Weight.new(@weight_info)
		@weight.user_id = @user.id
        @user.current_weight = @weight
        if @weight.save
          redirect_to(user_weight_path(@user.id, @weight.id))
        else
           render 'new_user_weight'
        end
	end
end
