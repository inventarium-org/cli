# frozen_string_literal: true
# this file is managed by dry-rb/devtools project

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inventarium/version'

Gem::Specification.new do |spec|
  spec.name          = 'inventarium'
  spec.authors       = ["Anton Davydov"]
  spec.email         = ["antondavydov.o+oss@gmail.com"]
  spec.license       = 'MIT'
  spec.version       = Inventarium::VERSION.dup

  spec.summary       = "CLI interface for inventarium.io"
  spec.description   = spec.summary
  spec.homepage      = 'https://inventarium.io'

  spec.bindir        = 'bin'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  # spec.metadata['changelog_uri']     = ''
  spec.metadata['source_code_uri']   = 'https://github.com/inventarium-org/cli'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/inventarium-org/cli/issues'

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_runtime_dependency "dry-cli", "~> 0.4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
