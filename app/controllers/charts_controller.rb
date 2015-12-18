class ChartsController < ApplicationController
  
  def index
  end

  def show
  	x_exercise_attempts = []
  	y_exercise_attempts = []
    @user = User.find(params[:user_id])
    @chart = @user.charts.find(params[:id])
    @attempts = @user.attempts.all
    x_exercise_attempts << @attempts.find_by(exercise_id: @chart.x_coordinate_exercise_id)
    y_exercise_attempts << @y_exercise_attempts = @attempts.find_by(exercise_id: @chart.y_coordinate_exercise_id)
    x_exercise_attempts.sort_by! do |attempt|
    	attempt[:score]
    end
    y_exercise_attempts.sort_by! do |attempt|
    	attempt[:score]
    end
    x_exercise = x_exercise_attempts.first
    y_exercise = y_exercise_attempts.first

exercises = []
exercises << {label: x_exercise.exercise.name, value: x_exercise.score}<<{ label: y_exercise.exercise.name, value: y_exercise.score}
  





@column_chart = Fusioncharts::Chart.new({
    type: 'column2d',
    renderAt: 'chart-container',
    width: '400',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Comparison of #{x_exercise.exercise.name} and #{y_exercise.exercise.name}",
                
            "xAxisName": "Movement",
            "yAxisName": "Weight",
            "paletteColors": "#0075c2",
            "bgColor": "#ffffff",
            "showBorder": "0",
            "showCanvasBorder": "0",
            "plotBorderAlpha": "10",
            "usePlotGradientColor": "0",
            "plotFillAlpha": "50",
            "showXAxisLine": "1",
            "axisLineAlpha": "25",
            "divLineAlpha": "10",
            "showValues": "1",
            "showAlternateHGridColor": "0",
            "captionFontSize": "14",
            "subcaptionFontSize": "14",
            "subcaptionFontBold": "0",
            "toolTipColor": "#ffffff",
            "toolTipBorderThickness": "0",
            "toolTipBgColor": "#000000",
            "toolTipBgAlpha": "80",
            "toolTipBorderRadius": "2",
            "toolTipPadding": "5"
            },
            data:  exercises
        #     	{
    				# :label => x_exercise.exercise.name,
   				 #    :value => x_exercise.score,
        #         },
        #         {
        #             :label => y_exercise.exercise.name,
        #             :value => y_exercise.score,
        #         }
            
        }
    })
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
