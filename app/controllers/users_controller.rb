class UsersController < ApplicationController
  def show
  	
  @user = User.find(params[:id])  

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
    type: 'area2d',
    renderAt: 'chart-container',
    width: '400',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Weight over time",
                
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
            data: weights_over_time
        }
    })
  end
end
