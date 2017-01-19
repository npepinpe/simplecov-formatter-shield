module SimpleCov
  module Formatter
    class ShieldFormatter
      class << self
        def filename
          return @filename ||= 'shield.png'
        end

        def filename=(filename)
          @filename = filename
        end

        def generator
          self.generator = :shields_io if @generator.nil?
          return @generator
        end

        def generator=(generator)
          @generator = case generator
          when :svg
            require 'simplecov-formatter-shield/generators/svg'
            SimpleCov::Formatter::ShieldFormatter::Generators::Svg
          when :png
            require 'simplecov-formatter-shield/generators/png'
            SimpleCov::Formatter::ShieldFormatter::Generators::Png
          when :shields_io
            require 'simplecov-formatter-shield/generators/shields_io'
            SimpleCov::Formatter::ShieldFormatter::Generators::ShieldsIO
          else
            Logger.warn("Unknown generator #{generator}; pick one of: :svg, :png, :shields_io")
          end

          return @generator
        end
      end

      TEXT = 'coverage'.freeze
      Options = Struct.new(:text, :color, :status)

      def format(result)
        percentage = result.covered_percent.to_f.round(2)
        options = Options.new(TEXT, color(percentage), status(percentage))
        puts "Created shield at #{output_path}" if write(image(options))
      rescue Generators::Error => error
        puts "Could not create shield: #{output_path} => #{error.message}"
      rescue IOError => error
        puts "Could not write file at #{output_path} => #{error.message}"
      end

      # Private API
      def write(bytes)
        File.open(output_path, 'wb') do |file|
          file << bytes
        end
      end
      private :write

      def output_path
        return File.join(SimpleCov.coverage_path, self.class.filename)
      end
      private :output_path

      def color(percentage)
        case percentage
        when 95..100
          :brightgreen
        when 80..95
          :green
        when 70..80
          :yellowgreen
        when 60..70
          :yellow
        when 40..60
          :orange
        else
          :red
        end
      end
      private :color

      def status(percentage)
        return "#{percentage}%"
      end
      private :status

      def image(options)
        generator = self.class.generator.new(options)
        return generator.generate
      end
      private :image
    end
  end
end
