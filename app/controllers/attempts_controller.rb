class AttemptsController < ApplicationController
  def index
    @user = User.find(params[:id])
  	@exercise = Exercise.find(params[:id])
  	@attempts = @exercise.attempts.all
  end

  def new
    @user = User.find(params[:id])
  	@exercise = Exercise.find(params[:id])
  	@attempt = @exercise.attempts.new	
  end

  def create
    @user = User.find(params[:id])
  	@exercise = Exercise.find(params[:id])
  	@attempt = @exercise.attempts.new(attempt_params)
  	@attempt.user_id = @exercise.user_id
  	  if @attempt.save
  	  	redirect_to exercise_attempts(@exercise.id)
  	  else
  	  	render 'new_exercise_attempt'
  	  end
  end

  private

  def attempt_params
  	params.require(:attempt).permit(:score)
  end
end
