class UserMailer < ApplicationMailer

	def convertido_mail(user, video) 
		@nombre_usuario = "Test"
		@nombre_video = "video test"
		@link_concurso = "localhost:3000"
		mail(to: "ekrivoy@gmail.com", subject: "SmartTools test email")
	end
end
