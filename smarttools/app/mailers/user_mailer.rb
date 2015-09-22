class UserMailer < ApplicationMailer

	def convertido_mail(user, video) 
		@nombre_usuario = user.nombre + user.apellido
		@nombre_video = video.nombre
		@link_concurso = Contest.find(video.contest_id).url
		mail(to: user.correo, subject: "Video de SmartTools Convertido")
	end
end
