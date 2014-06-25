json.array!(@stickers) do |sticker|
  json.extract! sticker, :id, :name, :photo, :description
  json.url sticker_url(sticker, format: :json)
end
