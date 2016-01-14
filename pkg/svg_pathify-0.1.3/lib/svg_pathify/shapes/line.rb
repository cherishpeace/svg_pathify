module SvgPathify

  module Shapes

    class Line < ::SvgPathify::Shape

      special_attr :x1, :y1, :x2, :y2

      def path_commands
        [
          "M#{x1} #{y1}",
          "L#{x2} #{y2}",
          "L#{x1} #{y1}",
          "Z"
        ].join
      end
    end

  end

end
