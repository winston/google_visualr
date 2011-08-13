module GoogleVisualr

  module Rails

    module ViewHelper

      extend ActiveSupport::Concern

      included do
        helper_method "render_chart"
      end

      module InstanceMethods
        def render_chart(dom, chart)
          chart.to_js(dom).html_safe
        end
      end

    end

  end

end
