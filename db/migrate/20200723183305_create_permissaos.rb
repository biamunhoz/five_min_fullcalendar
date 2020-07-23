class CreatePermissaos < ActiveRecord::Migration[5.2]
  def change
    create_table :permissaos do |t|
      t.references :usuarios, foreign_key: true
      t.references :salas, foreign_key: true
      t.references :perfils, foreign_key: true

      t.timestamps
    end
  end
end
