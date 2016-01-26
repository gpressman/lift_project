class WeightsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@user_weights = @user.weights.all
		@weights = Weight.all
	end

	def show
		
	end

	
	def new
		@user = current_user
		@weights = Weight.all
		@weight = Weight.new
	end

	def create
		@user = current_user	
		@weight= @user.weights.new(weight_params)
        @user.current_weight = @weight.weight
        @user.save
        if @weight.save
          redirect_to(user_path(@user))
        else
           render 'new_user_weight'
        end
	end

	def fc_json

@user = User.find(params[:user_id])
@weights = @user.weights.all
weights = @weights.select(:weight, :created_at)
weights_over_time = []


weights.each do |weight|
weights_over_time.push({
    :label => weight.created_at.strftime("%m-%-d-%y"),
    :value => weight.weight,
})
end
@chart = Fusioncharts::Chart.new({
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
            :data => weights_over_time
        }
    })
end 

	private

	def weight_params
		params.require(:weight).permit(:weight)
	end
end




