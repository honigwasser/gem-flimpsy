require "flickraw"

module Flimpsy
  module Api
    class Flickr
      FLICKR_API_KEY = "8762b4ac616f603e4688213afa3ad8fa".freeze
      FLICKR_SHARED_SECRET = "727f893ac73d0010".freeze

      class << self
        def most_popular_by_keyword(keyword)
          authenticate!
          response = flickr.photos.search(content_type: 1, sort: "relevance", tags: keyword,
                                          text: keyword, extras: "count_faves,tags,views,url_z",
                                          per_page: 1, format: "json")
          Flimpsy::Models::FlickrImage.from_response(response.first) if valid_response?(response)
        end

        private

        def authenticate!
          return if @authenticated
          FlickRaw.api_key = FLICKR_API_KEY
          FlickRaw.shared_secret = FLICKR_SHARED_SECRET
          @authenticated = true
        end

        def valid_response?(response)
          return false if response.size.zero?
          %w[count_faves views url_z].all? { |method| response.first.respond_to? method }
        end
      end
    end
  end
end
