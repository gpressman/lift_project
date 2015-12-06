class ChartsController < ApplicationController
  
  def index
  end

  def show
  	@user = current_user
  	@chart = @user.charts.find(params[:id])
  end

  def new
  	@user = current_user
  	@exercises = @user.exercises
  	@chart = @user.charts.new
  end

  def create
  	@user = current_user
  	@chart = @user.charts.new(chart_params)
  	  if @chart.save
  	  	redirect_to user_chart_path(@user, @chart)
  	  else
  	  	render 'new'
  	  end
  end

  private

  def chart_params
  	params.require(:chart).permit(:y_coordinate_exercise_id, :x_coordinate_exercise_id, :name)
  end
end
