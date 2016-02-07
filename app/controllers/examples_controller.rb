class ExamplesController < ApplicationController

def fc_json

@user = User.find(params[:user_id])
@weights = @user.weights.all
weights = @weights.select(:weight, :created_at)
weights_over_time = []


weights.each do |weight|
weights_over_time.push({
    :label => weight.created_at,
    :value => weight.weight,
})
end
@chart = Fusioncharts::Chart.new({
        
            data: weights_over_time
        }
    })
end 
end