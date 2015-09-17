json.array!(@users) do |user|
  json.extract! user, :id, :nombre, :apellido, :correo
  json.url user_url(user, format: :json)
end
