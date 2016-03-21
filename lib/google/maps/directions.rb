require "addressable"
require "open-uri"

module Google
  module Maps
    class Directions

      END_POINT = "https://maps.googleapis.com/maps/api/directions/json"

      def initialize(options = {})
        @options = {
          origin: "",
          destination: "",
          key: ENV["GOOGLE_MAPS_DIRECTIONS_KEY"],
          language: "en",
          units: "metric",
          mode: "transit",
          transit_mode: "subway"
        }.merge(options)
      end

      def uri
        return @uri if @uri
        uri = Addressable::URI.parse(END_POINT)
        uri.query_values = @options
        @uri = uri.to_s
      end

      # @return [JSON] answer from google maps direction API
      def get
        puts "Request to URI at #{DateTime.now}: #{uri}" if Rails.env.development?
        json = open(uri) { |f| f.read }
        JSON.parse(json)
      end

    end
  end
end
