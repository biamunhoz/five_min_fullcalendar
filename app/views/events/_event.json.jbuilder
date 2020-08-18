json.extract! event, :id, :title, :start_date, :timeini, :end_date, :timefim, :created_at, :updated_at
json.url event_url(event, format: :json)
