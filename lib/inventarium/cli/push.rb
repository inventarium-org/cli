module Inventarium
  module CLI
    class Push < Dry::CLI::Command
      desc "Push metainformation to inventarium service"

      example [
        "                              # Push service.yml from root folder",
        "./meta/specific_service.yml   # Push specific_service.yml from './meta' folder"
      ]

      def call(args: [], **)
        dir = args.first || './service.yml'
        puts "Push a new service.yml file from '#{dir}' directory"
      end
    end
  end
end
