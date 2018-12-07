class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|

      t.integer :player_id
      t.integer :total_wins
      t.integer :total_kills
      t.integer :total_matches
      t.float :kill_death_ratio
      t.integer :rank
      t.datetime :current_time


      t.timestamps
    end
  end
end
