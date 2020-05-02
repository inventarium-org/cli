require 'tty-progressbar'
require "pastel"
require 'net/http'
require 'yaml'
require 'json'

module Inventarium
  module CLI
    class Push < Dry::CLI::Command
      desc "Push metainformation to inventarium service"

      example [
        "                              # Push service.yml from root folder",
        "./meta/specific_service.yml   # Push specific_service.yml from './meta' folder"
      ]

      DEFAULT_BASE_URL = 'http://localhost:2300'

      def call(args: [], **)
        bar = TTY::ProgressBar.new("Puishing service.yaml to inventarium.io [:bar]", total: 30)

        path = args.first || './service.yml'

        bar.advance(10)

        config = parse_config(path)

        bar.advance(10)

        push_config(config)

        bar.advance(10)

        pastel = Pastel.new
        puts "[#{pastel.green('DONE')}]"
        # puts "Push a new service.yml file from '#{dir}' directory"
      end

    private

      def parse_config(path)
        YAML.load_file(path)
      end

      def push_config(config)
        base_url = ENV['INVENTARIUM_BASE_URL'] || DEFAULT_BASE_URL
        url = URI("#{base_url}/api/services")

        req = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
        req.body = { token: 'test', service: config }.to_json

        Net::HTTP.start(url.hostname, url.port) do |http|
          http.request(req)
        end
      end
    end
  end
end
