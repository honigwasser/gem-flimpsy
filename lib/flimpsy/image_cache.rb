require "open3"
require "open-uri"

module Flimpsy
  class ImageMagickError < StandardError; end

  class ImageCache
    class << self
      def resize_with_options(image)
        return image.resized if File.exist?(image.resized)
        get(image)
        convert(image)
        delete(image.cached)
        image.resized
      end

      private

      def get(image)
        IO.copy_stream(open(image.url), image.cached)
      end

      def delete(cached_image)
        File.delete(cached_image)
      end

      def convert(image)
        stdout, stderr, status = image_magick(image)
        raise ImageMagickError, "Status: #{status}\nStdout: #{stdout}\nStderr: #{stderr}" unless status.success?
      end

      # very private, almost intimate

      def image_magick(image)
        Open3.capture3(
          "convert", image.cached,                                              # What to convert?
          "-resize", "#{image.width}x#{image.height}^",                         # resizing
          "-gravity", "center", "-crop", "#{image.width}x#{image.height}+0+0",  # cropping
          "-background", "#ffffff",                                             # background color in case image was transparent
          "+repage", "-flatten",                                                # Discard canvas size and squash into single layer
          image.resized                                                         # Target path of output
        )
      end
    end
  end
end
