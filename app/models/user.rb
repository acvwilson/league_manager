class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  
  validates_presence_of :first_name, :last_name, :rank
  
  def name
    first_name << " " << last_name
  end
end
