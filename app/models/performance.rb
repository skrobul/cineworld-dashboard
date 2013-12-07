class Performance < ActiveRecord::Base
  attr_accessible :booking_url, :cinema, :film, :time, :type
  belongs_to :film
  belongs_to :cinema

  scope :current, -> { where("time >= ?", 60.minutes.ago )}

  def short_time
    "%02d:%02d" % [time.hour, time.min]
  end

end
