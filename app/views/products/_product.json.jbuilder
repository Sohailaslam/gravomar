json.extract! product, :id, :cost, :color, :height, :width, :price, :notes, :created_at, :updated_at
json.url product_url(product, format: :json)
