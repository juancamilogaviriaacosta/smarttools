class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :nombre
      t.string :apellido
      t.string :correo
      t.string :contrasena

      t.timestamps null: false
    end
  end
end
