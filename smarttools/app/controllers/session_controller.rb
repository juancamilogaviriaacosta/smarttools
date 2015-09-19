class SessionController < ApplicationController
  def new
  end
  
  def create
  	admin = Administrator.find_by(correo: params[:session][:correo].downcase);
  	if(admin && admin.contrasena == params[:session][:contrasena]) 
  		#Correct credentials
  		log_in admin
  		redirect_to admin
  	else 
  		#Incorrect credentials
  		flash.now[:danger] = "Credenciales invalidas"
  		@lol = "fail"
  		render :new
  	end
  end

  def destroy
  	log_out
  	redirect_to :home
  end
end
