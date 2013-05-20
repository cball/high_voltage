module HighVoltage
  module Constraints
    # Routing constraint to validate request.path has a corresponding view
    class RootRoute
      def self.matches?(request)
        pattern = file_pattern(request.path)

        Dir.glob(pattern).any?
      end

      private

      def self.file_pattern(page_id)
        if HighVoltage.convert_dash_in_url_to_underscore
          page_id = page_id.underscore
        end
        "#{content_path}#{page_id}.html*"
      end

      def self.content_path
        Rails.root.join('app', 'views', HighVoltage.content_path).to_s
      end
    end
  end
end
