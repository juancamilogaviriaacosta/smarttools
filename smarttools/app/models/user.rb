class User < ActiveRecord::Base
	validates :correo, uniqueness: true;
end
