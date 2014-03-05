module SvgPathify

  module Shapes

    class Ellipse < ::SvgPathify::Shape

      special_attr :cx, :cy, :rx, :ry

      def path_commands
        [
          "M#{cx-rx} #{cy}",
          "A#{rx},#{ry},0,1,1,#{cx-rx},#{cy+1}",
          "Z"
        ].join
      end
    end

  end

end
