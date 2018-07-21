json.extract! job, :id, :name, :phone, :material, :delivery_date, :quantity, :cost, :description, :created_at, :updated_at
json.url job_url(job, format: :json)
