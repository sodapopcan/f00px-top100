class Photo
  include Virtus.model

  attribute :name, String
  attribute :ranking, Float
  attribute :image_url, String
  attribute :user, User
end
