class WeightsController < ApplicationController

	def index
		@weights = Weight.all
	end

	def user_index
		@user = current_user
		@weights = @user.weight.all
	end
	
	def new
		@weights = Weight.all
		@weight = Weight.new
	end

	def create
		@user = current_user
		@weight_info = params.permit(:weight)
		@weight= Weight.new(@weight_info)
		@weight.user_id = @user.id
        @user.current_weight = @weight
        @weight.save
	end
end
