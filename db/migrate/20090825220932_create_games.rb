class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.datetime :start_time
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :field_number
      t.integer :league_id

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
