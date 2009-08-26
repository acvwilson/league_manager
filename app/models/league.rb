class League < ActiveRecord::Base
  has_many :teams
  has_many :games
end
