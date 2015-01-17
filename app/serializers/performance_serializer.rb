class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :short_time, :film_id, :booking_url, :decimal_time, :cinema_id
end
