# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html/pipeline/redcarpet_filter/version'

Gem::Specification.new do |spec|
  spec.name          = "html-pipeline-redcarpet_filter"
  spec.version       = HTML_Pipeline::RedcarpetFilter::VERSION
  spec.authors       = ["Brian Mikol"]
  spec.email         = ["github@sffogworks.com"]

  spec.summary       = "An HTML::Pipeline filter for Redcarpet."
  spec.description   = "Utilize this HTML::Pipeline filter to render Markdown text into HTML with Redcarpet."
  spec.homepage      = "https://github.com/bmikol/html-pipeline-redcarpet_filter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             "html-pipeline",      "~> 2.3"
  spec.add_dependency             "redcarpet",          "~> 3.3"

  spec.add_development_dependency "bundler",            "~> 1.11"
  spec.add_development_dependency "rake",               "~> 10.0"
  spec.add_development_dependency "minitest",           "~> 5.0"
  spec.add_development_dependency "guard",              "2.13.0"
  spec.add_development_dependency "guard-minitest",     "2.4.4"
  spec.add_development_dependency "minitest-reporters", "1.0.5"
end
