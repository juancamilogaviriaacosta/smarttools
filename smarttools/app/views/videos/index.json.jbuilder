json.array!(@videos) do |video|
  json.extract! video, :id, :nombre, :fechacreacion, :urloriginal, :urlconvertido, :estado, :descripcion, :contest_id, :user_id
  json.url video_url(video, format: :json)
end
