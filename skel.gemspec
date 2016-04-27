# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skel/version'

Gem::Specification.new do |spec|
  spec.name          = 'skel'
  spec.version       = Skel::VERSION
  spec.authors       = ['git']
  spec.email         = ['abhisawa@gmail.com']

  spec.summary       = 'Skeleton gem for ruby command line utility  '
  spec.description   = <<-FOO
This is Skeleton gem to build command line utility. It uses Thor instance for option parsing and command name creation,
provide logger object under singleton.
FOO
  spec.homepage      = 'https://github.com/abhisawa'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.license = 'MIT'

  spec.add_runtime_dependency 'thor', '~> 0.19.1'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
end
