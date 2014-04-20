class CinemaSerializer < ActiveModel::Serializer
  attributes :id, :name, :traffic_info
  has_many :films, embed: :ids
end
