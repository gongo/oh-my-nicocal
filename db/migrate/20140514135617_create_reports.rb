class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :mood_id
      t.date :date

      t.timestamps
    end
  end
end
