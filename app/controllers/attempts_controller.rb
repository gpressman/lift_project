class AttemptsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  	@attempts = @exercise.attempts.all
  end

  def new
  	@user = User.find(params[:user_id])
    @exercises = @user.exercises.all
  	@attempt = @user.attempts.new	
  end

  def create
  	@user = User.find(params[:user_id])
  	@attempt = @user.attempts.new(attempt_params)

  	  if @attempt.save
  	  	redirect_to user_exercise_path(@user, @attempt.exercise_id)
  	  else
  	  	render 'new_exercise_attempt'
  	  end
  end

  private

  def attempt_params
  	params.require(:attempt).permit(:score, :exercise_id)
  end
end
