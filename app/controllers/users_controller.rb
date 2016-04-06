class UsersController < ApplicationController
  def show

  
  @user = User.find(params[:id])  
  @exercises = @user.exercises.all
  @exercise = @user.exercises.build
  @weight = @user.weights.build
  @weights = @user.weights
  weights = @weights.select(:weight, :created_at)
  weights_over_time = []


weights.each do |weight|
weights_over_time.push({
    label: weight.created_at.strftime("%m-%-d-%y"),
    value: weight.weight,
})
end
@weights_chart = Fusioncharts::Chart.new({
    type: 'line',
    renderAt: 'chart-container',
    width: '400',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
        "caption": "Weight over time",
        "xAxisName": "Date",
        "yAxisName": "Weight",
        "lineThickness": "2",
        "paletteColors": "#0075c2",
        "baseFontColor": "#333333",
        "baseFont": "Helvetica Neue,Arial",
        "captionFontSize": "14",
        "subcaptionFontSize": "14",
        "subcaptionFontBold": "0",
        "showBorder": "0",
        "bgColor": "#ffffff",
        "showShadow": "0",
        "canvasBgColor": "#ffffff",
        "canvasBorderAlpha": "0",
        "divlineAlpha": "100",
        "divlineColor": "#999999",
        "divlineThickness": "1",
        "divLineIsDashed": "1",
        "divLineDashLen": "1",
        "divLineGapLen": "1",
        "showXAxisLine": "1",
        "xAxisLineThickness": "1",
        "xAxisLineColor": "#999999",
        "showAlternateHGridColor": "0"
            },
            data: weights_over_time
        }
    })
  end
end
