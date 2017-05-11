# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "flimpsy"
  spec.version       = "0.0.1"
  spec.authors       = ["Sven Sommerfeld"]
  spec.email         = ["sommerfeld@posteo.eu"]

  spec.summary       = "A glimpse into flickr"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.2"
  spec.add_dependency "sys-uname"
  spec.add_dependency "flickraw"
  spec.add_dependency "oily_png"
  spec.add_dependency "virtus"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock", "1.24.6"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "json_expressions"
end
