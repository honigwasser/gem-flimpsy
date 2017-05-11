module Flimpsy
  module Models
    class FlickrImage
      include Virtus.model

      attribute :id, Integer
      attribute :owner, String
      attribute :secret, String
      attribute :url, String
      attribute :tags, String
      attribute :title, String
      attribute :views, String, default: ""
      attribute :favorites, Integer, default: 0

      class << self
        def from_response(response)
          new(
            id: response.id.to_i,
            owner: response.owner,
            secret: response.secret,
            url: response.url_z,
            tags: response.tags,
            title: response.title,
            views: response.views,
            favorites: response.count_faves
          )
        end
      end
    end
  end
end
