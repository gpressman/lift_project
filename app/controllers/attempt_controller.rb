class AttemptController < ApplicationController
  def index
  	@exercise = Exercise.find(params[:id])
  	@attempts = @exercise.attempts.all
  end

  def new
  	@exercise = Exercise.find(params[:id])
  	@attempt = @exercise.attempts.new	
  end

  def create
  	@exercise = Exercise.find(params[:id])
  	@attempt = @exercise.attempts.new(attempt_params)
  	@attempt.user_id = @exercise.user_id
  	  if attempt.save
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
