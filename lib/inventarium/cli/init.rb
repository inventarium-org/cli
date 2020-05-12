module Inventarium
  module CLI
    class Init < Dry::CLI::Command
      desc "Create an empty service.yml file for the service"

      example [
        "                   # Generate service.yml in root folder",
        "./.service_meta/   # Generate service.yml in '.service_meta' folder",
        "order_service.yaml # Generate order_service.yml in root folder"
      ]

      def call(args: [], **)
        dir = args.first || '.'

        pastel = Pastel.new
        printf "Generating a new service.yaml\t\t"

        FileUtils.cp(template_file_path, dir)
        puts "[#{pastel.green('DONE')}]"
      end

    private

      def template_file_path
        File.expand_path(File.dirname(__FILE__) +  "/templates/service.yaml")
      end
    end
  end
end
