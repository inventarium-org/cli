module Inventarium
  module CLI
    class Push < Dry::CLI::Command
      desc "Push metainformation to inventarium service"

      def call(*)
        puts 'Pushing metainformation about service...'
      end
    end
  end
end
