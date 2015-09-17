json.array!(@administrators) do |administrator|
  json.extract! administrator, :id, :nombre, :apellido, :correo, :contrasena
  json.url administrator_url(administrator, format: :json)
end
