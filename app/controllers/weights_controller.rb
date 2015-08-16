class WeightsController < ApplicationController
	
	def new
		@weight = Weight.new
	end

	def create
		@user = current_user
		@weight_info = params.permit(:weight)
		@weight= Weight.new(@weight_info)
		@weight.user_id = @user.id
        @user.current_weight = @weight
	end
end
