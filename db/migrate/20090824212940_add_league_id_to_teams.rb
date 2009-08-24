class AddLeagueIdToTeams < ActiveRecord::Migration
  def self.up
    add_column "teams", "league_id", :integer
  end

  def self.down
    remove_column "teams", "league_id"
  end
end
