class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :nombre
      t.timestamp :fechacreacion
      t.string :urloriginal
      t.string :urlconvertido
      t.string :estado
      t.string :descripcion
      t.references :contest, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
