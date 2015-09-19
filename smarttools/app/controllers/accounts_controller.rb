class AccountsController < ApplicationController
  def login
  end

  def register
  end

  def restore
  end

  def create
  	admin = Administrator.new
  	admin.nombre = params[:nombre]
  	admin.apellido = params[:apellido]
  	admin.correo = params[:correo]
  	admin.contrasena = params[:contrasena]
  	admin.save
  	redirect_to "/contest"
  end
end
