class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  # GET /exercises
  # GET /exercises.json
  def index
    @user = User.find(params[:user_id])
    @exercises = @user.exercises.all
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    @user = User.find(params[:user_id])
    @exercise = @user.exercises.find(params[:id])
    @attempts = @exercise.attempts.all
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
    @exercise = Exercise.first_or_create(exercise_params)
    unless @user.exercises.where(name: @exercise.name).exists?
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
