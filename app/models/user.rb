class User < ActiveRecord::Base
  include Clearance::User
  has_and_belongs_to_many :teams
  
  attr_accessible :first_name, :last_name, :rank
  
  validates_presence_of :first_name, :last_name, :rank
  
  def name
    first_name << " " << last_name
  end
end
