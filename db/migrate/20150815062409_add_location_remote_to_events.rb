class AddLocationRemoteToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :location
    remove_column :events, :time
    add_column :events, :local_time, :string, null: false
    add_column :events, :remote_time, :string, null: false
    add_column :events, :local_location, :string, null: false
    add_column :events, :remote_location, :string, null: false
  end
end
