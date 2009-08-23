class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :rank
  
  def name
    first_name << " " << last_name
  end
end
