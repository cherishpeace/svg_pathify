module SvgPathify

  class Shape

    attr_accessor :node, :path, :special_attrs

    def initialize( node )
      @node = node
      special_attrs && special_attrs.each do |attr|
        self.send "#{attr}=", node[attr]
      end
    end

    def to_path_element
      node.document.create_element 'path', clean_attributes.merge( d: path_commands )
    end

    def path_commands
      nil
    end

    def clean_attributes
      node.attributes.reject {|k,v| attributes_to_delete.include?(k) }
    end

    def attributes_to_delete
      []
    end

    def self.inherited( clz )
      def clz.special_attr( *attrs )
        class_eval do 
          attr_accessor *attrs

          define_method :attributes_to_delete do
            attrs.map &:to_s
          end

          define_method :special_attrs do
            attrs
          end

          attrs.each do |the_attr|
            define_method the_attr do
              instance_variable_get( "@#{the_attr}" ).to_short_f
            end
          end

        end
      end
    end

  end

end
