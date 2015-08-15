class AddEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :time, null: false
      t.string :location, null: false

      t.timestamps null: false
    end
  end
end
