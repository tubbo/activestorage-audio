# frozen_string_literal: true

require_relative 'lib/active_storage/audio/version'

Gem::Specification.new do |spec|
  spec.name          = 'activestorage-audio'
  spec.version       = ActiveStorage::Audio::VERSION
  spec.authors       = ['Tom Scott']
  spec.email         = ['tubbo@psychedeli.ca']

  spec.summary       = 'Audio analyzer for uploaded files using ffprobe'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/tubbo/activestorage-audio'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] =
    'https://tubbo.github.io/activestorage-audio'
  spec.metadata['changelog_uri'] =
    'https://tubbo.github.io/activestorage-audio/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  # added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |path|
      path.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activestorage', '>= 5'
  spec.add_development_dependency 'mocha', '~> 1.11'
  spec.add_development_dependency 'rubocop', '~> 0.78'
end
