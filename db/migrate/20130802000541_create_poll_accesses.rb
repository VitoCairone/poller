class CreatePollAccesses < ActiveRecord::Migration
  def change
    create_table :poll_accesses do |t|
      t.integer :team_id, :presence => true
      t.integer :poll_id, :presence => true

      t.timestamps
    end
  end
end
