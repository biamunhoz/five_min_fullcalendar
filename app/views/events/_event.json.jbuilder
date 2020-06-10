json.extract! event, :id, :title, :string, :body, :string, :start_date, :datetime, :end_date, :datetime, :created_at, :updated_at
json.url event_url(event, format: :json)
