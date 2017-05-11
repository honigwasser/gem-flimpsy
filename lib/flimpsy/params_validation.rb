module Flimpsy
  class FlimpsyError < StandardError; end

  class ParamsValidation
    class << self
      def validate!(params)
        raise FlimpsyError, "No path given" unless params[:to_file]
        raise FlimpsyError, "Not an existing directory" unless valid_folder? params[:to_file]
        raise FlimpsyError, "Only PNG filenames allowed" unless valid_filename? params[:to_file]
        keywords = keyword_from_params params[:from_keywords]
        raise FlimpsyError, "No keywords given" if keywords.empty?
        [params[:to_file], keywords]
      end

      private

      def valid_folder?(filename)
        File.directory? File.dirname(filename)
      end

      def valid_filename?(filename)
        File.extname(filename).casecmp(".png").zero?
      end

      def keyword_from_params(list)
        return [] unless list
        list.split(/\s*,\s*/)
      end
    end
  end
end
