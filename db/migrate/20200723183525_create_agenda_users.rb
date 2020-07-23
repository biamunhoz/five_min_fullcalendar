class CreateAgendaUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :agenda_users do |t|
      t.references :usuarios, foreign_key: true
      t.references :agendas, foreign_key: true

      t.timestamps
    end
  end
end
