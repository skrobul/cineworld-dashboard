class Performance < ActiveRecord::Base
  attr_accessible :booking_url, :cinema, :film, :time, :performance_type
  belongs_to :film
  belongs_to :cinema

  scope :current, -> { where("time >= ?", 30.minutes.ago).where("time <= ?", Date.today + 1)}
  scope :past, -> { where("time <= ?", 30.minutes.ago )}
  scope :currently_for_film, ->(film_id=nil) { current.where(film_id: film_id) }

  def short_time
    "%02d:%02d" % [time.hour, time.min]
  end

  def decimal_time
    time.hour.to_i + (1 / (time.min / 60))
  end

end
