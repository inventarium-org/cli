module Inventarium
  module CLI
    class Version < Dry::CLI::Command
      desc "Print version"

      def call(*)
        puts Inventarium::VERSION
      end
    end
  end
end
