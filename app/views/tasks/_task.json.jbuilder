json.extract! task, :id, :name, :complete, :timelimit, :created_at, :updated_at
json.url task_url(task, format: :json)
