class CreateTeamsUsers < ActiveRecord::Migration
  def self.up
    create_table :teams_users, :id => false do |t|
      t.references :team
      t.references :user
    end
  end

  def self.down
    drop_table :teams_users
  end
end
