class Contest < ActiveRecord::Base

  has_attached_file :banner, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/

	belongs_to :administrator

	validates :nombre, presence: {message: 'El nombre no puede ser vacio'}
	validates :banner, presence:  {message: 'El banner no puede ser vacio'}
	validates :url, presence:  {message: 'La url no puede ser vacia'}
	validates :descripcion, presence:  {message: 'La descripción no puede ser vacia'}
	validates :premio, presence:  {message: 'El premio no puede ser vacio'}
	validate :fechas_validas
	
	def fechas_validas
		fInicial = Time.parse(fechainicio.to_s);
		fFinal = Time.parse(fechafin.to_s)
		if((fInicial + 60*60*24).past?)
			errors.add(:fechainicio, "La fecha inicial no puede haber pasado")
		end
		if((fFinal + 60*60*24).past?)
			errors.add(:fechainicio, "La fecha final no puede haber pasado")
		end
		if((fInicial <=> fFinal) == 1)
			errors.add(:fechainicio, "La fecha inicial no puede ser despues de la final")
		end
	end
end 