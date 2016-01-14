module SvgPathify

  module Shapes

    class Ellipse < ::SvgPathify::Shape

      special_attr :cx, :cy, :rx, :ry

      def path_commands
        [
          "M#{cx-rx} #{cy}",
          "a#{rx},#{ry},0,1,0,#{rx * 2},0",
          "a#{rx},#{ry},0,1,0,-#{rx * 2},0",
          "Z"
        ].join
      end
    end

  end

end
