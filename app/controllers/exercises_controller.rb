class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  layout "alternate", :only => :show

  # GET /exercises
  # GET /exercises.json
  def index
    @user = User.find(params[:user_id])
    @exercises = @user.exercises.all
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    @user = current_user
    @exercises = @user.exercises
    @exercise = Exercise.find(params[:id])
     @a = []
    @a << @exercise
    @attempt = @user.attempts.new
    @attempts = @exercise.attempts.where(user_id: current_user.id)   
    attempts = @attempts.select(:score, :created_at)
    scores_over_time = []
    attempts.each do |attempt|
      scores_over_time.push({
        label: attempt.created_at.strftime("%m-%-d-%y"),
        value: attempt.score,
      })
    end
    @exercise_chart = Fusioncharts::Chart.new({
    type: 'line',
    renderAt: 'chart-container',
    width: '400',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "#{@exercise.name} over time",
                
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
            data: scores_over_time
        }
    })
  
  end

  # GET /exercises/new
  def new
    @user = current_user
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @user = current_user
    @exercise = Exercise.new(exercise_params)
    @exercise = Exercise.where(name: @exercise.name).first_or_create(exercise_params)
    unless @user.exercises.where(name: @exercise.name).exists?
      @exercise.save
      @user.exercises <<  @exercise
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_exercises_path, notice: 'Exercise was successfully created.' }
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercises/1
  # PATCH/PUT /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to exercises_url, notice: 'Exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_params
      params.require(:exercise).permit(:name)
    end

     
end


