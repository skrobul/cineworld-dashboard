class Cinema < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :films
  has_many :performances, :through => :films

  def to_s
    "#{self.name}"
  end
end
