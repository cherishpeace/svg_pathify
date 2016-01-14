module SvgPathify

  module Shapes

    class Circle < ::SvgPathify::Shape

      special_attr :cx, :cy, :r

      def path_commands
        [
          "M#{cx} #{cy}",
          "m#{-r} 0",
          "a#{r},#{r} 0 1,0 #{r * 2},0",
          "a#{r},#{r} 0 1,0 -#{r * 2},0",
          "Z"
        ].join
      end

    end

  end
end
