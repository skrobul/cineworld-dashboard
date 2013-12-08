class Cinema < ActiveRecord::Base
  attr_accessible :id, :name
  has_and_belongs_to_many :films
  has_many :performances

  def to_s
    "#{self.name}"
  end
end
