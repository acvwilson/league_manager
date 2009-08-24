class AddSchedulingToLeagues < ActiveRecord::Migration
  def self.up
    add_column "leagues", "start_date", :date
    add_column "leagues", "end_date", :date
    remove_column "leagues", "season"
  end

  def self.down
    remove_column "leagues", "start_date"
    remove_column "leagues", "end_date"
    add_column "leagues", "season", :string
  end
end
