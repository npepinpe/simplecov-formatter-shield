lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplecov-formatter-shield/version'

Gem::Specification.new do |spec|
  spec.name          = 'simplecov-formatter-shield'
  spec.version       = SimpleCov::Formatter::ShieldFormatter::VERSION
  spec.authors       = ['Nicolas Pepin-Perreault']
  spec.email         = ['n.pepinpe@gmail.com']

  spec.summary       = %(SimpleCov formatter to generate TravisCI like shields.)
  spec.description   = %(SimpleCov formatter to generate TravisCI like shields with as little dependencies as possible.)
  spec.homepage      = 'https://github.com/npepinpe/simplecov-formatter-shield'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'simplecov', '> 0.11.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
