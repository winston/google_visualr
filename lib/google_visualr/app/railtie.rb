require "#{File.dirname(__FILE__)}/helpers/view_helper"

module GoogleVisualr

  module Rails

    class Railtie < ::Rails::Railtie

      initializer "google_visualr" do
        ActiveSupport.on_load(:action_controller) do
          include GoogleVisualr::Rails::ViewHelper
        end
      end

    end

  end

end
