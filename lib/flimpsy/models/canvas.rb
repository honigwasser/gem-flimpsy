require "oily_png"

module Flimpsy
  module Models
    class CanvasError < StandardError; end

    class Canvas
      CANVAS_POSITIONS = {
        "1" => [0, 0],
        "2" => [400, 0],
        "3" => [0, 200],
        "4" => [200, 200],
        "5" => [600, 200],
        "6" => [0, 400],
        "7" => [200, 400],
        "8" => [600, 400],
        "9" => [0, 600],
        "10" => [400, 600]
      }.freeze
      CROPPING_POSITIONS = [3, 5, 6, 8].freeze

      attr_accessor :png, :pos, :path

      def initialize(path)
        @path = path
        @pos = 1
        @png = ChunkyPNG::Image.new(800, 800, ChunkyPNG::Color.rgb(0, 0, 0))
        FileUtils.mkdir_p(File.dirname(path))
        png.save(path, :fast_rgba)
      end

      def add(file)
        raise CanvasError, "Too many images" if pos > 10
        image = ChunkyPNG::Image.from_file(file)
        add_image_to_canvas(image, pos)
        @pos += 1
      end

      private

      def add_image_to_canvas(image, position)
        image.crop!(100, 0, 200, 200) if CROPPING_POSITIONS.include? position
        x, y = CANVAS_POSITIONS[position.to_s]
        png.replace!(image, x, y)
        png.save(path, :fast_rgba)
      end
    end
  end
end
