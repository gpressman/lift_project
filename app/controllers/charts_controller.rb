class ChartsController < ApplicationController
  
  def index
  end

  def show
  	@chart = @user.charts.find(params[:id])
    @user = User.find(params[:user_id])
    @attempts = @user.attempts.all
    @x_exercise_attempts = @attempts.find_by(exercise_id: x_coordinate_exercise_id)
    @y_exercise_attempts = @attempts.find_by(exercise_id: y_coordinate_exercise_id)
    x_exercise = @x_exercise_attempts.order(score: :acd).first
    y_exercise = @y_exercise_attempts.order(score: :acd).first	

movements = []



movements.push({
    :label => x_exercise.name,
    :value => x_exercise.score,
})
end
@chart = Fusioncharts::Chart.new({
    type: 'column2d',
    renderAt: 'chart-container',
    width: '400',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Comparison of #{x_exercise.name} and #{y_exercise.name}",
                
            "xAxisName": "Date",
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
            :data => movements
        }
    })
end 
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
