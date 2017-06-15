require 'securerandom'
require 'erb'

module GoogleVisualr
  module Display

    def show_script(chart, dom=nil, options={})
      script_tag = options.fetch(:script_tag) { true }
      if script_tag
        chart.to_js(dom)
      else
        html = ""
        html << chart.load_js(dom)
        html << chart.draw_js(dom)
        html
      end
    end

    def show_html(chart, id=nil, options={})
      path = File.expand_path("../templates/chart_div.erb", __FILE__)
      template = File.read(path)
      id ||= SecureRandom.uuid()
      chart_script = show_script(chart, id, script_tag: false)
      ERB.new(template).result(binding)
    end

    def show_iruby(chart, dom=nil)
      IRuby.html(show_html(chart, dom))
    end

  end
end