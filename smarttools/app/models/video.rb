require 'streamio-ffmpeg'
require 'fileutils'

class Video < ActiveRecord::Base

  has_attached_file :videooriginals3
  do_not_validate_attachment_file_type :videooriginals3

	belongs_to :contest
	belongs_to :user

  #Transcodes this video to an mp4 (h.264/aac) format
  def convert_to_mp4
    #FFMPEG.ffmpeg_binary = '/usr/local/Cellar/ffmpeg/2.8.reinstall/bin/ffmpeg'
    #options = "-acodec aac -vcodec mpeg4 -strict experimental"
    #pathAOriginal = urloriginal.clone
    #pathAOriginal[0] = ''
    #pathAOriginal = File.join(Rails.public_path, pathAOriginal) 
    #ffMovie = FFMPEG::Movie.new(pathAOriginal)

    #nombreVideo = SecureRandom.uuid + ".mp4"
    #carpeta = File.join(Rails.public_path, "uploaded_videos", Time.now.strftime("%Y-%m-%d"), "processed")
    #rutaAbsoluta = File.join(carpeta, nombreVideo)
    #FileUtils.mkdir_p(carpeta)

    #self.urlconvertido = File.join("/uploaded_videos", Time.now.strftime("%Y-%m-%d"), "processed", nombreVideo)

    #ffMovie.transcode(rutaAbsoluta, options)





    carpeta = File.join(Rails.public_path, "tmp_videos", Time.now.strftime("%Y-%m-%d"))
    FileUtils.mkdir_p(carpeta)
    rutaAbsolutaTmp = File.join(carpeta, SecureRandom.uuid + ".mp4")
    download = open(self.videooriginals3.url)
    IO.copy_stream(download, rutaAbsolutaTmp)

    rutaAbsolutaConvertido = File.join(carpeta, SecureRandom.uuid + ".mp4")
    ffMovie = FFMPEG::Movie.new(rutaAbsolutaTmp)
    ffMovie.transcode(rutaAbsolutaConvertido, "-acodec aac -vcodec mpeg4 -strict experimental")

    AWS.config(access_key_id: ENV['KEY'], secret_access_key: ENV['SECRET'], region: 'us-west-2')
    s3 = AWS::S3.new
    archivo = File.basename(rutaAbsolutaConvertido)
    rutaS3 = 'videos/processed/' + Time.now.strftime("%Y-%m-%d") + "/" + archivo
    s3.buckets[ENV['BUCKET']].objects[rutaS3].write(:file => rutaAbsolutaConvertido)


    

    self.urlconvertido = 'https://s3-us-west-2.amazonaws.com/smarttoolscloud/' + rutaS3
    self.estado = 'proc'
    self.save

    UserMailer.convertido_mail(User.find(self.user_id), self).deliver
  end
  handle_asynchronously :convert_to_mp4
end
