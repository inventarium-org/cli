require "dry/cli"

module Inventarium
  module CLI
    extend Dry::CLI::Registry

    class Version < Dry::CLI::Command
      desc "Print version"

      def call(*)
        puts Inventarium::VERSION
      end
    end

    register "version", Version, aliases: ["v", "-v", "--version"]
  end
end

