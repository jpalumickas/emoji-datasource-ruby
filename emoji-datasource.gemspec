# frozen_string_literal: true

require_relative 'lib/emoji_datasource/version'

Gem::Specification.new do |spec|
  spec.name          = 'emoji-datasource'
  spec.version       = EmojiDatasource::VERSION
  spec.authors       = ['Justas Palumickas']
  spec.email         = ['jpalumickas@gmail.com']

  spec.summary       = 'Emoji data from emoji-datasource npm package'
  spec.description   = 'Emoji data from emoji-datasource ' \
                       '(https://github.com/iamcal/emoji-data) npm package'
  spec.homepage      = 'http://github.com/jpalumickas/emoji-datasource-ruby'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jpalumickas/emoji-datasource-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/jpalumickas/emoji-datasource-ruby/releases'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/jpalumickas/emoji-datasource-ruby/issues'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{\A(?:test|spec|features|node_modules)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.16'
  spec.add_development_dependency 'simplecov', '~> 0.21'
end
