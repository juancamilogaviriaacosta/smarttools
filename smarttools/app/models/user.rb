class User  < ActiveRecord::Base
	include Dynamoid::Document
	
	field :nombre
	field :apellido
	field :correo

	#validates :correo, uniqueness: true;
end
