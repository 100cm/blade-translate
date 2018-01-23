# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blade/translate/version'

Gem::Specification.new do |spec|
  spec.name          = "blade-translate"
  spec.version       = Blade::Translate::VERSION
  spec.authors       = ["icepoint0"]
  spec.email         = ["351711778@qq.com"]

  spec.summary       = "blade translate"
  spec.description   = "blade translate"
  spec.homepage      = "http://thunderjava.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency  "rainbow" ,"~>2.1.0"
end
