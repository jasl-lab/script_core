# frozen_string_literal: true

require "pathname"

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "script_core/version"

Gem::Specification.new do |spec|
  spec.name = "script_core"
  spec.version = ScriptCore::VERSION
  spec.summary = "A script engine powered by mruby sandboxie, It's a fork of Shopify's ESS."
  spec.authors = ["jasl"]
  spec.email = "jasl9187@hotmail.com"
  spec.files = begin
    submodules =
      `git submodule status --recursive`.split("\n").map do |submodule|
        submodule.split(/\(|\s+/)[2]
      end.compact

    list_tracked_files = lambda do |dir|
      Dir.chdir(Pathname.new(__FILE__).dirname.join(dir)) do
        `git ls-files -z`.split("\x0").map do |file|
          Pathname.new(dir).join(file).to_s
        end
      end
    end

    list_tracked_files.call(".") + submodules.flat_map do |submodule|
      list_tracked_files.call(submodule)
    end
  end

  spec.extensions = ["ext/enterprise_script_service/Rakefile"]
  spec.homepage = "https://github.com/rails-engine/script_core"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5"

  spec.add_dependency("msgpack", "~> 1.0")
  spec.add_dependency("rake-compiler", "~> 1.0")

  spec.add_development_dependency("rake", "~> 13")
  spec.add_development_dependency("rspec", "~> 3.5")
end
