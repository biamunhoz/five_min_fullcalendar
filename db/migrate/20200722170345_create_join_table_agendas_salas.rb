class CreateJoinTableAgendasSalas < ActiveRecord::Migration[5.2]
  def change
    create_join_table :agendas, :salas do |t|
      # t.index [:agenda_id, :sala_id]
      # t.index [:sala_id, :agenda_id]
    end
  end
end
