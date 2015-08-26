json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :name, :has_and_belongs_to_many
  json.url exercise_url(exercise, format: :json)
end
