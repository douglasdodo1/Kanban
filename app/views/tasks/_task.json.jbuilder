json.extract! task, :id, :tittle, :description, :status, :priority, :assignee, :created_at, :updated_at
json.url task_url(task, format: :json)
