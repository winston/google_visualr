module GoogleVisualr

  module Packages

    def package_name
      self.class.to_s.split("::").last.downcase
    end

    def class_name
      self.class.to_s.split('::').last
    end

    module CoreChart
      def package_name
        "corechart"
      end
    end

    module ImageChart
      def package_name
        "image#{self.class.to_s.split("::").last.downcase}"
      end
      def class_name
        "Image#{self.class.to_s.split('::').last}"
      end
    end

  end

end