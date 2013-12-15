class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :short_time, :film_id, :booking_url, :time, :cinema_id
end
