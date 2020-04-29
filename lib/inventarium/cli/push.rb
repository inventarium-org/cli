require 'tty-progressbar'
require "pastel"

module Inventarium
  module CLI
    class Push < Dry::CLI::Command
      desc "Push metainformation to inventarium service"

      example [
        "                              # Push service.yml from root folder",
        "./meta/specific_service.yml   # Push specific_service.yml from './meta' folder"
      ]

      def call(args: [], **)
        # dir = args.first || './service.yml'
        bar = TTY::ProgressBar.new("Puishing service.yaml to inventarium.io [:bar]", total: 30)
        10.times do
          sleep(0.1)
          bar.advance(3)
        end

        pastel = Pastel.new
        puts "[#{pastel.green('DONE')}]"
        # puts "Push a new service.yml file from '#{dir}' directory"
      end
    end
  end
end
