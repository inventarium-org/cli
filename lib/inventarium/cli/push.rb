require 'tty-progressbar'
require 'net/http'
require 'yaml'
require 'json'
require 'pp'

module Inventarium
  module CLI
    class Push < Dry::CLI::Command
      desc "Push metainformation to inventarium service"

      example [
        "                              # Push service.yml from root folder",
        "./meta/specific_service.yml   # Push specific_service.yml from './meta' folder"
      ]

      DEFAULT_BASE_URL = 'https://app.inventarium.io'

      def call(args: [], **)
        path = args.first || './service.yml'

        bar = TTY::ProgressBar.new("Puishing #{path} to inventarium.io [:bar]", total: 30)
        bar.advance(10)

        config = parse_config(path)

        bar.advance(10)

        response = push_config(config)

        bar.advance(10)

        pastel = Pastel.new

        case response.code
        when '200'
          puts "[#{pastel.green('DONE')}]"

          exit(0) # success exist
        when '401' #  Unauthorized
          puts "[#{pastel.red('FAIL')}] #{response.body}"
        when '403' #  Forbidden
          puts "[#{pastel.red('FAIL')}] #{response.body}"
        when '422' # invalid data
          puts "[#{pastel.red('FAIL')}]"
          pp JSON.parse(response.body)
        when '500'
          puts "[#{pastel.red('FAIL')}] Service error, please try later or create an issue in https://github.com/inventarium-org/core"
        end

        exit(1)
      end

    private

      def parse_config(path)
        YAML.load_file(path)
      end

      def push_config(config)
        base_url = ENV['INVENTARIUM_BASE_URL'] || DEFAULT_BASE_URL
        url = URI("#{base_url}/api/services")

        token = ENV['INVENTARIUM_TOKEN'].to_s

        req = Net::HTTP::Post.new(url, 'X-INVENTARIUM-TOKEN' => token, 'Content-Type' => 'application/json')
        req.body = { token: token, service: config }.to_json

        http = Net::HTTP.new(url.hostname, url.port)
        http.use_ssl = (url.scheme == "https")
        http.request(req)
      end
    end
  end
end
