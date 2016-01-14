require 'test/unit'
$: << File.expand_path( '../lib/', File.basename(__FILE__) )

require 'svg_pathify'

class SvgPathifyTest < Test::Unit::TestCase

  def test_nothing_changed_if_no_shape_available
    input = %Q{<path d="M93.992 83.676m-67.244 0a67.244,67.244 0 1,0 134.488,0a67.244,67.244 0 1,0 -134.488,0Z" />}

    assert_xml_equal input, SvgPathify.convert( input )
  end

  def test_rect_changes_to_path_tag
    input   = %Q{<rect x="100" y="300" width="50" height="200" />}
    output  = %Q{<path d="M100 300l50 0l0 200l-50 0l0 -200Z" />}

    assert_xml_equal output, SvgPathify.convert( input )
  end

  def test_circle_changes_to_path_tag
    input   = %Q{<circle x="100" y="300" r="50" cx="100" cy="200" />}
    output  = %Q{<path x="100" y="300" d="M100 200m-50 0a50,50 0 1,0 100,0a50,50 0 1,0 -100,0Z" />}

    assert_xml_equal output, SvgPathify.convert( input )
  end

  def test_polygon_changes_to_path_tag
    input   = %Q{<polygon points="350,75  379,161 469,161 397,215
                    423,301 350,250 277,301 303,215
                    231,161 321,161" />}
    output  = %Q{<path d="M350,75L379,161L469,161L397,215L423,301L350,250L277,301L303,215L231,161L321,161Z" />}

    assert_xml_equal output, SvgPathify.convert( input )
  end

  def test_polyline_changes_to_path_tag
    input   = %Q{<polyline points="350,75  379,161 469,161 397,215
                    423,301 350,250 277,301 303,215
                    231,161 321,161" />}
    output  = %Q{<path d="M350,75L379,161L469,161L397,215L423,301L350,250L277,301L303,215L231,161L321,161Z" />}

    assert_xml_equal output, SvgPathify.convert( input )
  end

  def test_line_changes_to_path_tag
    input   = %Q{<line x1="900" y1="300" x2="1100" y2="100" stroke-width="25" />}
    output  = %Q{<path d="M900 300L1100 100L900 300Z" stroke-width="25" />}

    assert_xml_equal output, SvgPathify.convert( input )
  end

  def test_ellipse_changes_to_path_tag
    input   = %Q{<ellipse
        rx="250" ry="100"
        fill="none" stroke="blue" stroke-width="20"  />}
    output  = %Q{<path d="M-250 0a250,100,0,1,0,500,0a250,100,0,1,0,-500,0Z"
      stroke-width="20"
      fill="none"
      stroke="blue" />}

    assert_xml_equal output, SvgPathify.convert( input )
  end

  def test_deep_search
    input   = %Q{<g><ellipse
        rx="250" ry="100"
        fill="none" stroke="blue" stroke-width="20" /></g>}
    output  = %Q{<g><path d="M-250 0a250,100,0,1,0,500,0a250,100,0,1,0,-500,0Z"
      stroke-width="20"
      fill="none"
      stroke="blue" /></g>}

    assert_xml_equal output, SvgPathify.convert( input )

  end

  #-----> helper

  def assert_xml_equal( expect, other, msg=nil )
    assert_equal Nokogiri::XML( expect, &:noblanks ).root, Nokogiri::XML( other, &:noblanks ).root
  end

end

class Nokogiri::XML::Node
  # Return true if this node is content-equivalent to other, false otherwise
  def == (other)
    return true if self.object_id == other.object_id
    return false if other.nil?
    return false unless name == other.name
    stype = node_type; otype = other.node_type
    return false unless stype == otype
    sa = attributes; oa = other.attributes
    return false unless sa.length == oa.length
    sa = sa.sort.map{ |n,a| [n,a.value,a.namespace && a.namespace.href] }
    oa = oa.sort.map{ |n,a| [n,a.value,a.namespace && a.namespace.href] }
    return false unless sa == oa
    skids = children; okids = other.children
    return false unless skids.length == okids.length
    return false if stype == TEXT_NODE && (content != other.content)
    sns = namespace; ons = other.namespace
    return false if !sns ^ !ons
    return false if sns && (sns.href != ons.href)
    skids.to_a.uniq.sort == okids.to_a.uniq.sort
  end
end
