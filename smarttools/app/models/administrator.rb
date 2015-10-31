require 'time'
#require 'aws-sdk'
#require 'dynamoid'

class Administrator # < ActiveRecord::Base
	#include Dynamoid::Document
=begin
	field :nombre
        field :apellido
        field :correo
	field :contrasena
=end
#	table :key => :id
	validates_presence_of :correo, message: 'El correo no puede ser vacio'
	validates :correo, uniqueness: {case_sensitive: false, message: 'Este correo ya ha sido registrado'}
	validates_confirmation_of :contrasena, message: "Las contraseñas no son iguales"
	validates_presence_of :contrasena, message: 'La contraseña no puede ser vacia'
	validates_presence_of :contrasena_confirmation, message: 'La confirmación de la contraseña no puede ser vacia'
end
