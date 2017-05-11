module Flimpsy
  class App
    PANIC_KEYWORDS = %w[sunset beach water sky red nature blue night white
                        tree green forest portrait art light snow dog sun clouds cat
                        park winter landscape street summer sea city trees yellow lake].freeze

    class << self
      def run(params)
        path, keywords = Flimpsy::ParamsValidation.validate!(params)
        images = images_from_keywords(keywords) # get some images via flickr
        images = maybe_add_some(images)         # we need ten images
        cached_images = resize_images(images)   # resize and cache images
        build_grid(path, cached_images)         # build a college grid
        cleanup                                 # clean up old files
        path                                    # return the output path
      end

      private

      def images_from_keywords(keywords)
        keywords.map do |keyword|
          Flimpsy::Api::Flickr.most_popular_by_keyword(keyword)
        end.compact
      end

      def maybe_add_some(images)
        return images unless images.size < 10
        additional_keywords = PANIC_KEYWORDS.sample(10 - images.size)
        additional_images = images_from_keywords(additional_keywords)
        images + additional_images
      end

      def resize_images(images)
        images.map do |image|
          options = Flimpsy::Models::ImageConfig.from_params(image.url, 400, 200, "png")
          Flimpsy::ImageCache.resize_with_options(options)
        end
      end

      def build_grid(path, images)
        canvas = Flimpsy::Models::Canvas.new(path)
        images.each { |image| canvas.add(image) }
      end

      def cleanup
        cached_files = File.join(IMAGE_CACHE, "*.png")
        Dir[cached_files].each do |path|
          FileUtils.rm(path, force: true) if ::File.stat(path).ctime < (Time.now - 60 * 5)
        end
      end
    end
  end
end
