# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "svg_pathify"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["qhwa"]
  s.date = "2013-11-12"
  s.email = "qhwa@163.com"
  s.files = ["README.md", "Rakefile", "svg_pathify.gemspec", "lib/svg_pathify.rb", "lib/svg_pathify", "lib/svg_pathify/to_short_f.rb", "lib/svg_pathify/shapes", "lib/svg_pathify/shapes/rect.rb", "lib/svg_pathify/shapes/polygon.rb", "lib/svg_pathify/shapes/line.rb", "lib/svg_pathify/shapes/circle.rb", "lib/svg_pathify/shapes/ellipse.rb", "lib/svg_pathify/shape.rb", "test/svg_pathify_test.rb"]
  s.homepage = "https://github.com/qhwa/svg_pathify"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "turn svg shape tags into <path> tag."
end
