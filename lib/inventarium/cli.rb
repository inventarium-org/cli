require "dry/cli"
require_relative "./cli/version"
require_relative "./cli/init"
require_relative "./cli/push"

module Inventarium
  module CLI
    extend Dry::CLI::Registry

    register "version", Version, aliases: ["v", "-v", "--version"]

    register "init",    Init
    register "push",    Push
  end
end

