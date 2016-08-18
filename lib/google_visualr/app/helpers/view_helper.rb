module GoogleVisualr
  module Rails
    module ViewHelper
      extend ActiveSupport::Concern

      included do
        helper_method 'add_chart'
        helper_method 'load_libraries'
        helper_method 'render_chart'
      end

      def add_chart(chart, dom, options={})
        script_tag = options.fetch(:script_tag) { true }
        if script_tag
          chart.to_js(dom).html_safe
        else
          html = ''
          html << chart.callback_js(dom)
          html << chart.draw_js(dom)
          html.html_safe
        end
      end

      def load_libraries(packages, language=nil)
        language_opt = ", language: '#{language}'" unless language.nil?
        packages_list = packages.nil? ? 'corechart' : packages.join("','")
        packages_opt = "'packages': ['#{packages_list}']"

        js =  "\n<script type=\"text/javascript\">"
        js << "\n  google.charts.load('current', {#{packages_opt}#{language_opt}});"
        js << "\n</script>"
        js.html_safe
      end

      def render_chart(chart, dom, options={})
        output = chart.loader_js
        output << add_chart(chart, dom, options)
        output.html_safe
      end
    end
  end
end
