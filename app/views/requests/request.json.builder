json.extract! request, :title, :content, :created_at, :updated_at
json.url request_url(request, format: :json)
