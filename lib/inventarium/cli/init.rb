module Inventarium
  module CLI
    class Init < Dry::CLI::Command
      desc "Generate a new service.yml file for specific service"

      def call(*)
        puts 'Created a new service.yml file'
      end
    end
  end
end
