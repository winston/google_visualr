require 'byebug'
module GoogleVisualr

  # generate initializing code
  def self.generate_init_code
    js_dir = File.expand_path("../js", __FILE__)
    path = File.expand_path("../templates/init.inline.js.erb", __FILE__)
    template = File.read(path)
    ERB.new(template).result(binding)
  end

  # Enable to show plots on IRuby notebook
  def self.init_iruby
    js = self.generate_init_code
    IRuby.display(IRuby.javascript(js))
  end

end
