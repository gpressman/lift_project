class Exercise < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :attempts

  def find_percent(exercise)
  	@user = current_user
  	@attempts = @user.attempts.all
    @exercise_attempts = @attempts.find_by(exercise_id: exercise1.id)
    @exercise_attempts.order(score: :acd)
  end

end
