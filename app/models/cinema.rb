class Cinema < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :films

  def self.populate_observed
    interesting_cinemas = [89, 25, 30, 65, 60] 
    
  end

  def to_s
    "#{self.name}"
  end
end
