module SvgPathify

  module Shapes

    class Rect < ::SvgPathify::Shape

      special_attr :width, :height, :x, :y

      def path_commands
        "M#{x} #{y}l#{width} 0l0 #{height}l#{-width} 0l0 #{-height}Z"
      end

    end

  end
end
