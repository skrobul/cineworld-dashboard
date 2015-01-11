class CinemaSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_name
  has_many :films, embed: :ids
end
