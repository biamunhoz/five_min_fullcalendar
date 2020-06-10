class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :string
      t.string :body
      t.string :string
      t.string :start_date
      t.string :datetime
      t.string :end_date
      t.string :datetime

      t.timestamps
    end
  end
end
