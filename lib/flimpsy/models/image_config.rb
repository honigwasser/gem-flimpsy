require "fileutils"
require "open3"

module Flimpsy
  module Models
    class ImageConfig
      include Virtus.model

      attribute :url, String
      attribute :cached, String, default: ""
      attribute :resized, String, default: ""
      attribute :height, Integer, default: 500
      attribute :width, Integer, default: 500
      attribute :image_format, String, default: "png"

      def dimensions
        {
          cached: dims(cached),
          resized: dims(resized)
        }
      end

      class << self
        def from_params(url, width, height, image_format)
          new(
            url: url,
            height: height,
            width: width,
            image_format: image_format,
            cached: cached_path(url),
            resized: resized_path(url, height, width, image_format)
          )
        end

        private

        def cached_path(url)
          File.join(IMAGE_CACHE, Digest::MD5.hexdigest(url))
        end

        def resized_path(u, h, w, f)
          file_name = Digest::MD5.hexdigest(u)
          FileUtils.mkdir_p(IMAGE_CACHE)
          File.join(IMAGE_CACHE, "#{file_name}_#{w}x#{h}.#{f}")
        end
      end

      private

      def dims(p)
        dim, _stderr, _status = Open3.capture3("identify", "-format", "%w,%h", p)
        return nil if dim.empty?
        values = dim.split(",").map(&:to_i)
        {
          width: values.first,
          height: values.last
        }
      end
    end
  end
end
