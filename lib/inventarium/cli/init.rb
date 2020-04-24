module Inventarium
  module CLI
    class Init < Dry::CLI::Command
      desc "Create an empty service.yml file for the service"

      example [
        "                # Generate service.yml in root folder",
        "./.service_meta # Generate service.yml in '.service_meta' folder"
      ]

      def call(args: [], **)
        dir = args.first || '.'
        puts "Created a new service.yml file in '#{dir}' directory"
      end
    end
  end
end
