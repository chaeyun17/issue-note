json.extract! article, :id, :url, :title, :summary, :press, :publishedAt, :reporter, :created_at, :updated_at
json.url article_url(article, format: :json)
