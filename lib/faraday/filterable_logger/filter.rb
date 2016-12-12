module Faraday
  module FilterableLogger
    class Filter
      def initialize(params_to_filter)
        @params_to_filter = Array(params_to_filter).map(&:to_sym)
      end

      def filter_url(url)
        filtered_query = filter(CGI::parse(url.query.to_s))
        url.query      = filtered_query.map { |params| params.join("=") } * "&"

        url
      end

      private
      def filter(hash)
        hash.map do |key, value|
          [
            key,
            @params_to_filter.include?(key.to_sym) ? "[FILTERED]": value
          ]
        end.to_h
      end
    end
  end
end
