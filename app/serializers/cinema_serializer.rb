class CinemaSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :films, embed: :ids
end
