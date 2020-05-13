require 'erb'

module Inventarium
  module CLI
    class TemplateGenerator
      def call(dir:, payload:)
        template = File.read(template_file_path)
        result = ERB.new(template).result(binding)

        File.open(dir, 'w') { |f| f.write(result) }
      end

    private

      def template_file_path
        File.expand_path(File.dirname(__FILE__) +  "/templates/service.yaml.erb")
      end
    end
  end
end
