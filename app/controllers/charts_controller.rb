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
        "xaxismaxvalue": "1000",
        "xaxisminvalue": "100",
        "yaxismaxvalue": "1000",
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
            "anchorbordercolor": "#f8bd19",
            "data": [
                {
                    "id": "Mob_1",
                    "y": "335",
                    "x": "156"
                },
                {
                    "id": "Mob_2",
                    "y": "339",
                    "x": "927"
                },
                {
                    "id": "Mob_3",
                    "y": "328",
                    "x": "847"
                },
                {
                    "id": "Mob_4",
                    "y": "1",
                    "x": "177"
                },
                {
                    "id": "Mob_5",
                    "y": "246",
                    "x": "175"
                },
                {
                    "id": "Mob_6",
                    "y": "368",
                    "x": "441"
                },
                {
                    "id": "Mob_7",
                    "y": "146",
                    "x": "200"
                },
                {
                    "id": "Mob_8",
                    "y": "347",
                    "x": "482"
                },
                {
                    "id": "Mob_9",
                    "y": "1",
                    "x": "463"
                },
                {
                    "id": "Mob_10",
                    "y": "63",
                    "x": "440"
                },
                {
                    "id": "Mob_11",
                    "y": "77",
                    "x": "211"
                },
                {
                    "id": "Mob_12",
                    "y": "108",
                    "x": "824"
                },
                {
                    "id": "Mob_13",
                    "y": "44",
                    "x": "850"
                },
                {
                    "id": "Mob_14",
                    "y": "77",
                    "x": "712"
                },
                {
                    "id": "Mob_15",
                    "y": "15",
                    "x": "199"
                },
                {
                    "id": "Mob_16",
                    "y": "333",
                    "x": "836"
                },
                {
                    "id": "Mob_17",
                    "y": "31",
                    "x": "482"
                },
                {
                    "id": "Mob_18",
                    "y": "90",
                    "x": "604"
                },
                {
                    "id": "Mob_19",
                    "y": "294",
                    "x": "716"
                },
                {
                    "id": "Mob_20",
                    "y": "241",
                    "x": "870"
                },
                {
                    "id": "Mob_21",
                    "y": "258",
                    "x": "421"
                },
                {
                    "id": "Mob_22",
                    "y": "186",
                    "x": "456"
                },
                {
                    "id": "Mob_23",
                    "y": "255",
                    "x": "327"
                },
                {
                    "id": "Mob_24",
                    "y": "203",
                    "x": "995"
                },
                {
                    "id": "Mob_25",
                    "y": "35",
                    "x": "792"
                }
            ]
        }
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
