json.array!(@contests) do |contest|
  json.extract! contest, :id, :nombre, :banner, :url, :descripcion, :premio, :fechainicio, :fechafin, :administrator_id
  json.url contest_url(contest, format: :json)
end
