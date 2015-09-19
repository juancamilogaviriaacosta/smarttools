class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :nombre
      t.string :banner
      t.string :url
      t.string :descripcion
      t.string :premio
      t.timestamp :fechainicio
      t.timestamp :fechafin
      t.references :administrator, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
