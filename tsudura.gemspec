# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tsudura/version'

Gem::Specification.new do |spec|
  spec.name          = "tsudura"
  spec.version       = Tsudura::VERSION
  spec.authors       = ["onigra"]
  spec.email         = ["3280467rec@gmail.com"]

  spec.summary       = %q{Update ami and launch_config and auto scaling group like packer.}
  spec.description   = %q{Command line tool of create new ami and update auto scaling group and delete old ami and launch config.}
  spec.homepage      = "https://github.com/onigra/tsudura"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "growl"
  spec.add_development_dependency "awesome_print"

  spec.add_dependency "thor"
  spec.add_dependency "aws-sdk", '~> 2'
  spec.add_dependency "deep_hash_transform"
end
