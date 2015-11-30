require 'streamio-ffmpeg'
require 'fileutils'
require 'paperclip' 

class Video < ActiveRecord::Base

    begin
        has_attached_file :videooriginals3
        do_not_validate_attachment_file_type :videooriginals3
    rescue
    end

	belongs_to :contest
	belongs_to :user

  def convert_to_mp4

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

    self.urlconvertido = 'https://' + ENV['CLOUDFRONT_DIST'] + '/' + rutaS3
    self.estado = 'proc'
    self.save

    UserMailer.convertido_mail(User.find(self.user_id), self).deliver
  end
  handle_asynchronously :convert_to_mp4
end
