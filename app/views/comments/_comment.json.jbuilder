json.extract! comment, :id, :body, :author, :note_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
