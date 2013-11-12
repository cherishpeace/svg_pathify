module SvgPathify

  module Shapes

    # Example:
    # <polygon fill="#ED1C24" points="68.793,3.148 51.865,19 86.795,19 "/>
    class Polygon < ::SvgPathify::Shape

      def path_commands
        pts = node['points'].split.map {|pos| pos.split(',').map(&:to_short_f) }

        paths = []
        pts.each_with_index do |dot, i|
          if i.zero?
            paths << "M#{dot.join ?,}"
          else
            paths << "L#{dot.join ?,}"
          end
        end
        paths << "Z"
        paths.join
      end

      def attributes_to_delete
        "points"
      end

    end

  end
end
