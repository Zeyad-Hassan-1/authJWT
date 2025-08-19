# frozen_string_literal: true

require_relative "lib/jwt_rails_api_auth/version"

Gem::Specification.new do |spec|
  spec.name = "jwt_rails_api_auth"
  spec.version = JwtRailsApiAuth::VERSION
  spec.authors = ["Zeyad Hassan"]
  spec.email = [" studying.zezo@gmail.com"]

  spec.summary = "Provides Rails generators for authentication, user management, password resets, and mailers, streamlining the setup of secure user authentication in Rails applications."
  spec.homepage = "https://github.com/Zeyad-Hassan-1/authJWT.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.files = Dir.glob(%w[
    lib/**/*.rb
    lib/**/*.tt
    lib/**/*.erb
    lib/generators/**/*
    bin/*
    [A-Z]*
  ]).reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "bcrypt", '>= 3.1.12'
  spec.add_dependency "jwt", "~> 2.5"
  spec.add_dependency "rack-cors"
  spec.add_dependency "active_model_serializers", "~> 0.10.12"
  # spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "Put your gem's public repo URL here."
  #   spec.metadata["changelog_uri"] = "Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # gemspec = File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
  #   end
  # end
  # spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  # spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
