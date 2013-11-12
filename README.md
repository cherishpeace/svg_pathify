**svg_pathify** turns svg [basic shapes](http://www.w3.org/TR/SVG/shapes.html) into path svg elements.

## install

~~~
gem install svg_pathify
~~~

or in your Gemfile:

~~~
gem 'svg_pathify'
~~~

## usage


~~~ruby
input  = %Q{<polyline points="350,75  379,161 469,161 397,215
                423,301 350,250 277,301 303,215
                231,161 321,161" />}

output = SvgPathify.convert( input )
#=> '<path d="M350,75L379,161L469,161L397,215L423,301L350,250L277,301L303,215L231,161L321,161Z" />'
~~~

