class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.string :human_name
      t.string :uuid
      t.string :minor
      t.string :major
      t.string :location

      t.timestamps
    end
  end
end
