require 'nokogiri'
require_relative 'svg_pathify/to_short_f'
require_relative 'svg_pathify/shape'

Dir.glob( File.expand_path( "svg_pathify/shapes/*.rb", File.dirname(__FILE__) ) ) do |shape|
  require shape
end

module SvgPathify
  
  class << self
    def convert svg_xml
      Converter.new(svg_xml).output
    end
  end

  class Converter

    attr_reader :input

    def initialize( svg )
      @xml = Nokogiri::XML( svg, &:noblanks )
      @converted_root = convert_node @xml.root
    end

    def output
      @converted_root.to_s
    end

    protected 


      CONVERTING_MAP = {
        :rect     => ::SvgPathify::Shapes::Rect,
        :circle   => ::SvgPathify::Shapes::Circle,
        :polygon  => ::SvgPathify::Shapes::Polygon,
        :polyline => ::SvgPathify::Shapes::Polygon,
        :line     => ::SvgPathify::Shapes::Line,
        :ellipse  => ::SvgPathify::Shapes::Ellipse
      }

      def convert_node( node )
        return node if node.text?

        type = CONVERTING_MAP[node.name.to_sym]
        return node if type.nil?

        type.new( node ).to_path_element
      end

  end

end
