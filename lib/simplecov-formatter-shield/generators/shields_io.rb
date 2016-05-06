require 'net/http' # I know this is terrible, but it avoids additional dependencies

module SimpleCov
  module Formatter
    class ShieldFormatter
      module Generators
        # TODO: Make configurable
        class ShieldsIO < StandardError
          HOST = 'img.shields.io'.freeze
          PATH = 'badge'.freeze
          EXTENSION = 'png'.freeze
          STYLE = 'flat'.freeze

          def initialize(options)
            @options = options
            @image = nil
          end

          def generate
            return @image ||= begin
              generate!
            end
          end

          def generate!
            uri = build_uri
            response = Net::HTTP.get_response(uri)
            raise(Generators::Error, "Could not fetch image at #{uri} => #{response.msg} (#{response.code})") unless (200..399).cover?(response.code.to_i)

            return response.body
          end
          private :generate!

          def build_uri
            parts = [@options.text, @options.status, @options.color].map { |part| URI.encode(part.to_s) }
            path = "/#{PATH}/#{parts.join('-')}.#{EXTENSION}"
            return URI::HTTPS.build(host: HOST, path: path, query: "style=#{STYLE}")
          end
        end
      end
    end
  end
end
