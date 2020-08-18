class AddTimeToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :timeini, :string
    add_column :events, :timefim, :string    
  end
end
