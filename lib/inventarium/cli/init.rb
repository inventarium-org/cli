require "tty-prompt"

module Inventarium
  module CLI
    class Init < Dry::CLI::Command
      desc "Create an empty service.yml file for the service"

      example [
        "                   # Generate service.yml in root folder",
        "./.service_meta/   # Generate service.yml in '.service_meta' folder",
        "order_service.yaml # Generate order_service.yml in root folder"
      ]

      CLASSIFICATION_VALUES = %w[critical normal internal experiment]
      STATUS_VALUES = %w[adopt hold trial in_development]

      def call(args: [], **)
        dir = args.first || './service.yaml'
        result = base_service_information

        pastel = Pastel.new
        printf "Generating a new service.yaml\t\t"

        TemplateGenerator.new.call(dir: dir, payload: result)

        puts "[#{pastel.green('DONE')}]"
      end

    private

      def base_service_information
        prompt = TTY::Prompt.new
        name = prompt.ask('A name of the service:', required: true)

        key = prompt.ask("A uniq key for service (you can use only chars, integers, '_' and '-'):", required: true) do |q|
          q.validate(/\A[a-zA-Z0-9_-]+\Z/, "Invalid key value, please use only chars, integers and '-'")
        end

        classification = prompt.select("Choose service classification", CLASSIFICATION_VALUES, symbols: {marker: '>'})
        status = prompt.select("Choose service status", STATUS_VALUES, symbols: {marker: '>'})

        { name: name, key: key, classification: classification, status: status }
      end
    end
  end
end
