module SvgPathify

  module Shapes

    class Rect < ::SvgPathify::Shape

      special_attr :width, :height

      def path_commands
        "M0 0l#{width} 0l0 #{height}l#{-width} 0l0 #{-height}Z"
      end

    end

  end
end
