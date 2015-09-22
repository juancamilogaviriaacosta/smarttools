require 'streamio-ffmpeg'
require 'fileutils'

class Video < ActiveRecord::Base
	belongs_to :contest
	belongs_to :user

  #Transcodes this video to an mp4 (h.264/aac) format
  def convert_to_mp4
FFMPEG.ffmpeg_binary = 'dependencies/ffmpeg'
    options = "-f mp4 -strict -2"
    pathAOriginal = urloriginal.clone
    pathAOriginal[0] = ''
    pathAOriginal = File.join(Rails.public_path, pathAOriginal) 
    ffMovie = FFMPEG::Movie.new(pathAOriginal)

    nombreVideo = SecureRandom.uuid + ".mp4"
    carpeta = File.join(Rails.public_path, "uploaded_videos", Time.now.strftime("%Y-%m-%d"), "processed")
    rutaAbsoluta = File.join("/uploaded_videos", Time.now.strftime("%Y-%m-%d"), "processed", nombreVideo)
    FileUtils.mkdir_p(carpeta)

    self.urlconvertido = rutaAbsoluta

    ffMovie.transcode(urlconvertido, options)

    self.estado = 'proc'
    self.save

    UserMailer.convertido_mail(User.find(self.user_id), self).deliver
  end
  handle_asynchronously :convert_to_mp4
end
