

json.extract! project, :id, :name, :complete, :timelimit, :created_at, :updated_at
json.url project_url(project, format: :json)
