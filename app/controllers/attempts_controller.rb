class AttemptsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  	@attempts = @user.attempts.all
  end

  def new
  	@user = current_user
    @exercises = @user.exercises.all
  	@attempt = @user.attempts.new	
  end

  def create
  	@user = current_user
  	@attempt = @user.attempts.new(attempt_params)

  	  if @attempt.save
  	  	redirect_to user_exercise_path(@user, @attempt.exercise_id)
  	  else
  	  	render 'new_user_attempt'
  	  end
  end

  private

  def attempt_params
  	params.require(:attempt).permit(:score, :exercise_id)
  end
end
