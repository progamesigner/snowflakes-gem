require File.expand_path("../lib/snowflakes/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name = 'snowflakes'
  spec.version = Snowflakes.version
  spec.license = 'MIT'

  spec.authors = [
    'Yang Sheng Han'
  ]
  spec.email = [
    'progamesigner@gmail.com'
  ]
  spec.homepage = 'https://github.com/progamesigner/snowflakes-gem'

  spec.summary = 'A decentralized, k-ordered UUID generator in Ruby'
  spec.description = 'Snowflakes produces 128-bit and time-ordered ids. They run one on each node in infrastructure and will generate conflict-free ids on-demand without coordination.'

  spec.files = Dir[
    'README.md',
    'LICENSE',
    'snowflakes.gemspec',
    'lib/**/*.rb'
  ]
end
