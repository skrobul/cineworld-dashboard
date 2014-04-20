class CinemaSerializer < ActiveModel::Serializer
  attributes :id, :name, :traffic_info, :short_name
  has_many :films, embed: :ids
end
