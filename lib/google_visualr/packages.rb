module GoogleVisualr
  module Packages

    def package_name
      self.class.to_s.split('::').last.downcase
    end

    module CoreChart
      def package_name
        "corechart"
      end
    end

  end
end