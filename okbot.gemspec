# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'okbot/version'

Gem::Specification.new do |spec|
  spec.name          = "okbot"
  spec.version       = Okbot::VERSION
  spec.authors       = ["zainal mustofa"]
  spec.email         = ["zainalmustof@gmail.com"]

  spec.summary       = %q{BLITZ and StackOverFlow}
  spec.description   = %q{Your smart assistances}
  spec.homepage      = "http://rubygems.org/gems/okbot"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = 'MIT'

  spec.add_dependency 'thor', "~> 0.19.1"
  spec.add_dependency 'httparty', "~> 0.14.0"
  spec.add_dependency 'rainbow', "~> 2.0.0"
  spec.add_dependency 'nokogiri', '~> 1.6.8'
  spec.add_dependency 'json', "~> 1.8.3"
  spec.add_dependency 'highline', "~> 1.7.8"
  spec.add_dependency 'terminal-table', "~> 1.6.0"

  spec.add_development_dependency 'pry', "~> 0.10.4"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end