require 'directions'

class Cinema < ActiveRecord::Base
  attr_accessible :id, :name, :postcode
  has_and_belongs_to_many :films
  has_many :performances

  def to_s
    "#{self.short_name}"
  end

  def short_name
    name.gsub("London - ", '')
  end

  def traffic_info
    begin
      info = Rails.cache.fetch("traffic/#{self.id}", expires_in: 10.minutes) do
          dir = GoogleDirections.get_duration_and_distance :origin => "W7 3PX", :destination => self.postcode
          self.duration = dir[:duration]["value"]
          if self.distance == nil
            self.distance_will_change!
            self.distance =  dir[:distance]["value"].to_i
            self.save!
          end
          dir
      end
    rescue Exception => e
      logger.info "Problem with fetching traffic information: #{e.to_s}"
      nil
    end
  end
end
