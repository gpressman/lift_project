class ChartsController < ApplicationController
  
  def index
  end

  def show
  	x_exercise_attempts = []
  	y_exercise_attempts = []
    @user = User.find(params[:user_id])
    @chart = @user.charts.find(params[:id])
    @attempts = @user.attempts.all
    
    #finds all attempts for the selected movements by the user
    @attempts.each do |attempt|
      if attempt.exercise_id == @chart.x_coordinate_exercise_id
        x_exercise_attempts << attempt
      elsif attempt.exercise_id == @chart.y_coordinate_exercise_id
        y_exercise_attempts << attempt
      end
    end
        
    # @x_exercise_attempts = @attempts.where(exercise_id: @chart.x_coordinate_exercise_id)
    # @y_exercise_attempts = @attempts.find_by(exercise_id: @chart.y_coordinate_exercise_id)
    
    #finds the highest scored attempt
    x_exercise_attempts.sort! do |attempt1, attempt2|
    	attempt2[:score] <=> attempt1[:score]
    end
    y_exercise_attempts.sort! do |attempt1, attempt2|
    	attempt2[:score] <=> attempt1[:score]
    end
    x_exercise = x_exercise_attempts.first
    y_exercise = y_exercise_attempts.first

   

    #puts the best attempts exercise and score in an array.
    exercises = []
    exercises << {label: x_exercise.exercise.name, value: x_exercise.score}<<{ label: y_exercise.exercise.name, value: y_exercise.score}
  
    #find all users who have both selected movements 
    @users = User.all
    @global_users = []
    @users.each do |user|
        if user.exercises.include?(Exercise.find_by(id: @chart.x_coordinate_exercise_id)) && user.exercises.include?(Exercise.find_by(id: @chart.y_coordinate_exercise_id))
          @global_users << user
        end
      
    end

   
    
    
    
  
    global_exercises = []



    @global_users.each do |user|
      @attempts = user.attempts
      
       x_exercise_attempts.sort! do |attempt1, attempt2|
      attempt2[:score] <=> attempt1[:score]
    end
    y_exercise_attempts.sort! do |attempt1, attempt2|
      attempt2[:score] <=> attempt1[:score]
    end
      x_exercise = x_exercise_attempts.first
      y_exercise = y_exercise_attempts.first
      global_exercises << {x: x_exercise.score, y: y_exercise.score}
    end




@column_chart = Fusioncharts::Chart.new({
    type: 'column2d',
    renderAt: 'column-container',
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
        }
    })

@scatter_chart = Fusioncharts::Chart.new({
    type: 'scatter',
    renderAt: 'scatter-container',
    width: '400',
    height: '300',
    dataFormat: 'json',
    dataSource: {
    "chart": {
        "theme": "fint",
        "caption": "Global Comparison of #{x_exercise.exercise.name} and #{y_exercise.exercise.name}",
        "subcaption": "Harry's SuperMart - Last Week",
        "yaxisname": "#{y_exercise.exercise.name}",
        "xaxisname": "#{x_exercise.exercise.name}",
        "xaxismaxvalue": "1100",
        "yaxismaxvalue": "1100",
        "xnumbersuffix": "pounds",
        "ynumbersuffix": " pounds",
        "showcanvasborder": "1",
        "canvasborderthickness": "0.4",
        "canvasborderalpha": "50",
        "showXAxisLine": "0",
        "showformbtn": "1",
        "formAction": "#",
        "submitdataasxml": "1"
    },
    # "categories": [
    #     {
    #         "verticallinecolor": "666666",
    #         "verticallinethickness": "1",
    #         "alpha": "40",
    #         "category": [
    #             {
    #                 "label": "$100",
    #                 "x": "100",
    #                 "showverticalline": "0"
    #             },
    #             {
    #                 "label": "$200",
    #                 "x": "200",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$300",
    #                 "x": "300",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$400",
    #                 "x": "400",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$500",
    #                 "x": "500",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$600",
    #                 "x": "600",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$700",
    #                 "x": "700",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$800",
    #                 "x": "800",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$900",
    #                 "x": "900",
    #                 "showverticalline": "1"
    #             },
    #             {
    #                 "label": "$1000",
    #                 "x": "1000",
    #                 "showverticalline": "0"
    #             }
    #         ]
    #     }
    # ],
    "dataset": [
        {
            "drawline": "0",
            "seriesname": "user #{current_user.id}",
            "color": "#6baa01",
            "anchorsides": "3",
            "anchorradius": "4",
            "anchorbgcolor": "#6baa01",
            "anchorbordercolor": "#6baa01",
            "data": [
                {
                  "id": "user #{current_user.id}",
                  "y": "#{y_exercise.score}",
                  "x": "#{x_exercise.score}"
                }
            ]
        },
        {
            "seriesname": "Cell Phones",
            "color": "#f8bd19",
            "anchorsides": "4",
            "anchorradius": "4",
            "anchorbgcolor": "#f8bd19",
            "anchorbordercolor": "#f8bd19"
        },
            data: global_exercises
               
            ]
        
    
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
