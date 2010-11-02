module GoogleVisualr
	class TextStyle
		attr_accessor :color
		attr_accessor :fontName
		attr_accessor :fontSize
		
		def to_s
			attributes = Array.new
			instance_variable_names.each do |instance_variable|
				key 				= instance_variable.gsub("@", "")
				value 			= GoogleVisualr::typecast(instance_variable_get(instance_variable))
				attributes << "#{key}: #{value}"
			end
			return "{#{attributes.join(', ')}}"
		end
	end
end
