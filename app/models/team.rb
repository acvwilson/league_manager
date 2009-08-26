class Team < ActiveRecord::Base
  validates_presence_of :name
  
  has_and_belongs_to_many :users
  
  has_many :games
  belongs_to :league
  
end
