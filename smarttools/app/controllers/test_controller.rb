class TestController < ApplicationController
	
	def video_test
		nombreVideo = "test.webm"
		carpeta = File.join(Rails.public_path, "uploaded_videos", Time.now.strftime("%Y-%m-%d"))
		rutaAbsoluta = File.join(carpeta, nombreVideo)
		FileUtils.mkdir_p(carpeta)
		File.open(rutaAbsoluta, 'wb') do |f|
			f.write(video_params[:videooriginals3].read)
		end

		user = User.find_by(correo: params[:correo_usuario])

		if !user
			user = User.create({:nombre => params[:nombre_usuario], :apellido => params[:apellido_usuario], :correo => params[:correo_usuario]})
		end

		newParams = {:nombre => video_params[:nombre], :descripcion => video_params[:descripcion], :fechacreacion => Time.now, :urlconvertido => nil,
			:urloriginal => "/uploaded_videos/" + Time.now.strftime("%Y-%m-%d") + "/" + nombreVideo, 
			:contest_id => params[:contest_id], :estado => 'to_proc', :user_id => user.id, :videooriginals3 => video_params[:videooriginals3]}

			@video = Video.new(newParams)
			respond_to do |format|
				if @video.save
					@video.convert_to_mp4
					format.html { redirect_to @video, notice: 'Video was successfully created.' }
					format.json { render :show, status: :created, location: @video }
				else
					format.html { render :new }
					format.json { render json: @video.errors, status: :unprocessable_entity }
				end
			end
		end

		def mail_test
			user = {nombre:"test", apellido:"test", correo:"ekrivoy@gmail.com"}
			video = {nombre:"videoTest", contest_id:0}
			UserMailer.convertido_mail(user, video).deliver_now
		end
	end
