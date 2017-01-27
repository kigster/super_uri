# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_uri/version'

Gem::Specification.new do |spec|
  spec.name          = "super_uri"
  spec.version       = SuperUri::VERSION
  spec.authors       = ["Konstantin Gredeskoul"]
  spec.email         = ["kigster@gmail.com"]

  spec.summary       = %q{Placeholder: Gem to read/write to URIs}
  spec.description   = %q{Placeholder: Gem to read/write to URIs}
  spec.homepage      = "https://github.com/kigster/super_uri"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end