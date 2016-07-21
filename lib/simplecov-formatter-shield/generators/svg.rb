require 'erb'
require 'tempfile'
require 'mini_magick'

module SimpleCov
  module Formatter
    class ShieldFormatter
      module Generators
        class Svg
          CHAR_WIDTH = 0.7 * 10
          PADDING = 4
          COLOR_MAP = {
            brightgreen: [nil, '#4c1'],
            green: [nil, '#97CA00'],
            yellow: [nil, '#dfb317'],
            yellowgreen: [nil, '#a4a61d'],
            orange: [nil, '#fe7d37'],
            red: [nil, '#e05d44']
          }.freeze

          def initialize(options)
            @options = options
            @template = ERB.new(File.read(File.expand_path('../svg/template.svg.erb', __FILE__)))
            @image = nil
          end

          def generate
            return @image ||= begin
              generate!
            end
          end

          def inspect
            return "#{self.class.name}: options => <#{@options}>"
          end

          def generate!
            texts = self.texts
            widths = self.widths
            colors = self.colors

            return @template.result(binding)
          end
          private :generate!

          def texts
            return @texts ||= [@options.text, @options.status]
          end
          protected :texts

          def widths
            return @widths ||= texts.map { |str| (str.length * CHAR_WIDTH).ceil + PADDING + 1 }
          end
          protected :widths

          def colors
            return @colors ||= COLOR_MAP[@options.color]
          end
          protected :colors
        end
      end
    end
  end
end
