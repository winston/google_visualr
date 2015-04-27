module GoogleVisualr
  module Rails
    module ViewHelper
      extend ActiveSupport::Concern

      included do
        helper_method "render_chart"
      end

      def render_chart(chart, dom, options={})
        script_tag = options.fetch(:script_tag) { true }

        # render material based charts
        is_material_chart = options.fetch(:material) { false }

        if is_material_chart
          chart.to_material_js(dom).html_safe
        elsif script_tag
          chart.to_js(dom).html_safe
        else
          html = ""
          html << chart.load_js(dom)
          html << chart.draw_js(dom)
          html.html_safe
        end
      end
    end
  end
end
