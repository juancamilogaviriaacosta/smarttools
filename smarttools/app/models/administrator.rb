require 'time'
#require 'aws-sdk'
#require 'dynamoid'

class Administrator # < ActiveRecord::Base
	include Dynamoid::Document

	field :nombre
        field :apellido
        field :correo
	field :contrasena

	table :key => :id
	#validates :correo, presence: {message: 'El correo no puede ser vacio'}
	#validates :correo, uniqueness: {case_sensitive: false, message: 'Este correo ya ha sido registrado'}
	#validates :contrasena, confirmation: {message: "Las contraseñas no son iguales"}
	#validates :contrasena, presence: {message: 'La contraseña no puede ser vacia'}
	#validates :contrasena_confirmation, presence: {message: 'LA confirmación de la contraseña no puede ser vacio'}
end
