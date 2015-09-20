require 'streamio-ffmpeg'
require 'fileutils'

class Video < ActiveRecord::Base
	belongs_to :contest
	belongs_to :user

  #Transcodes this video to an mp4 (h.264/aac) format
  def convert_to_mp4
  	FFMPEG.ffmpeg_binary = 'dependencies/ffmpeg'
  	options = "-f mp4 -strict -2"
  	ffMovie = FFMPEG::Movie.new(urloriginal)

  	newFileName = nombre + '.mp4'
  	path = File.join("uploaded_videos","processed", contest_id.to_s)
  	fullFilePath = File.join(path,newFileName)

  	self.urlconvertido = fullFilePath

  	FileUtils.mkdir_p(path);

  	ffMovie.transcode(urlconvertido, options)

  	self.estado = 'proc'
  	FileUtils.rm(urloriginal)
  	self.save
  end
  handle_asynchronously :convert_to_mp4
end
