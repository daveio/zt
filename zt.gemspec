
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zt/version"

Gem::Specification.new do |spec|
  spec.name          = "zt"
  spec.version       = Zt::VERSION
  spec.authors       = ["Dave Williams"]
  spec.email         = ["dave@dave.io"]

  spec.summary       = %q{ZeroTier administration toolbox}
  spec.description   = %q{Utilities and glue to make working with ZeroTier networks a bit more friendly}
  spec.homepage      = "https://github.com/daveio/zt"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://localhost" # TODO: allow push to rubygems
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/daveio/zt"
    spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/daveio/zt/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.0"
  spec.add_development_dependency "dotenv", "~> 2.0"
end
