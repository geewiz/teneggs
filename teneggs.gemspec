require_relative 'lib/teneggs/version'

Gem::Specification.new do |spec|
  spec.name          = "teneggs"
  spec.version       = Teneggs::VERSION
  spec.authors       = ["Jochen Lillich"]
  spec.email         = ["contact@geewiz.dev"]

  spec.summary       = %q{Twitch chat bot}
  spec.description   = %q{Twitch chat bot}
  spec.homepage      = "https://github.com/geewiz/teneggs"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/geewiz/teneggs"
  spec.metadata["changelog_uri"] = "https://www.github.com/geewiz/teneggs"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dotenv"
  spec.add_dependency "twitch-bot", "~> 1.0"

  spec.add_development_dependency "freistil-rubocop"
end