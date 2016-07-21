require 'simplecov-formatter-shield/generators/svg'
require 'tempfile'
require 'mini_magick'

module SimpleCov
  module Formatter
    class ShieldFormatter
      module Generators
        class Png < Svg
          def generate!
            return svg2png(super)
          end
          private :generate!

          def svg2png(svg)
            image = MiniMagick::Image.create('.svg') do |tmpfile|
              tmpfile.write(svg)
            end

            image.format('png') do |converter|
              converter.resize "#{widths.reduce(&:+)}x20"
              converter.background 'transparent'
              converter.alpha 'on'
            end

            return image.to_blob
          end
        end
      end
    end
  end
end
