class AttemptController < ApplicationController
  def index
  	@exercise = Exercise.find(params[:id])
  	@attempts = @exercise.attempts.all
  end
end
