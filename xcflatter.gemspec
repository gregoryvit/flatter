
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "xcflatter/version"

Gem::Specification.new do |spec|
  spec.name          = "xcflatter"
  spec.version       = Flatter::VERSION
  spec.authors       = ["Gregory Berngardt"]
  spec.email         = ["gregoryvit@gmail.com"]

  spec.summary       = %q{Flatter is a gem which move all files with specific extension in xCode project to root group.}
  spec.description   = %q{Flatter is a gem which move all files with specific extension in xCode project to root group.}
  spec.homepage      = "https://github.com/gregoryvit/flatter"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["flatter"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "xcodeproj", "~> 1.0"

end
